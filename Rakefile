require 'rake'
require 'rake/testtask'
require 'yaml'
require './lib/afo'
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
  t.test_files = FileList['test/unit/*_test.rb']
  t.verbose = true
end

task :load_test_data do
  comics = YAML.load(File.read("test/data/data.yml"))
  comics[:comics].each { |hash| hash[:file] = File.read hash[:orig_path] }
                 .map { |c| Afo::Comic.new c }.map(&:save)
end

task :destroy_test_data do
  comics = YAML.load(File.read("test/data/data.yml"))
  records = comics[:comics].map { |c| Afo::Comic.first :title => c[:title] }.compact
  records.map(&:destroy)
end