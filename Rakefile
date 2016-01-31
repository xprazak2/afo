require 'rake'
require 'rake/testtask'
require 'yaml'
require 'rack'
require 'fileutils'
require 'git'
require 'logger'

task :start do
  #sh "thin -p 4567 -D -R config.ru start"
end

task :devel_start do
  exec "shotgun config.ru"
end

task :default => :test

Rake::TestTask.new(:test) do |t|
  t.libs << '.'
  t.libs << 'lib'
  t.libs << 'test'
  t.test_files = FileList['test/unit/*_test.rb', 'test/functional/*_test.rb', 'test/auth/*_test.rb']
  t.verbose = true
end

task :load_sample_data do
  require './lib/afo'
  comics = YAML.load(File.read("test/data/data.yml"))
  comics[:comics].each { |hash| hash[:file] = Base64.encode64(File.read(hash[:name])) }
                 .map { |c| Afo::Comic.new c }.map(&:save)
end

task :destroy_sample_data do
  require './lib/afo'
  comics = YAML.load(File.read("test/data/data.yml"))
  records = comics[:comics].map { |c| Afo::Comic.first :title => c[:title] }.compact
  records.map(&:destroy)
end

#http://stackoverflow.com/questions/4008028/get-ordered-list-of-middleware-in-a-generic-rack-application
task :middleware do
  def middleware_classes(app)
    r = [app]

    unless (next_app = r.last.instance_variable_get(:@app)) == nil
      r << next_app
    end

    r.map { |e| e.instance_variable_defined?(:@app) ? e.class : e }
  end
  app = Rack::Builder.parse_file('config.ru').first
  p middleware_classes(app)
end

namespace :deploy do
  @logger = Logger.new(STDOUT)
  @config = "./config/settings.d/settings.local.yml"
  @config_backup = "./config/settings.d/settings.production.yml"

  def copy_file(source, dest)
    if File.exist?(source)
       @logger.debug FileUtils.pwd
    else
      @logger.debug "#{source} does not exist for #{FileUtils.pwd}"
    end
    @logger.debug FileUtils.cp(source, dest, :verbose => true) if File.exist? source
  end

  #rake deploy:production['heroku-app-name']
  task :production, [:app] => [:backup_settings, :reboot]

  task :backup_settings do
    git = Git.open('.', :log => @logger)
    git.branch('master').checkout
    new_branch = "heroku_deploy_#{Time.now.to_i}"
    git.branch(new_branch).checkout
    copy_file @config, @config_backup
    git.add
    git.commit "Rake auto commit before heroku deploy"
    git.push 'heroku', "#{new_branch}:master", :force => true
    git.branch('master').checkout
  end

  task :reboot, :app do |t, args|
    system "heroku restart --app #{args[:app]}"
  end
end
