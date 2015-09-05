require 'rake'
require 'rake/testtask'

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
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end