require 'rake'
require 'rake/testtask'
require 'yaml'
require 'pry'



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
  t.test_files = FileList['test/unit/*_test.rb', 'test/functional/*_test.rb']
  t.verbose = true
end

task :load_sample_data do
  require './lib/afo'
  comics = YAML.load(File.read("test/data/data.yml"))
  comics[:comics].each { |hash| hash[:file] = File.read hash[:orig_path] }
                 .map { |c| Afo::Comic.new c }.map(&:save)
end

task :destroy_sample_data do
  require './lib/afo'
  comics = YAML.load(File.read("test/data/data.yml"))
  records = comics[:comics].map { |c| Afo::Comic.first :title => c[:title] }.compact
  records.map(&:destroy)
end

task :install_assets do
  # TODO: Handle node installation on Debian/RH systems
end