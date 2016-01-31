source 'http://rubygems.org'
ruby '2.1.5'

gem 'rake'
gem 'sinatra', ' ~> 1.4.6'
gem 'sinatra-initializers'
gem 'data_mapper', '~> 1.2.0'
gem 'dm-postgres-adapter'
gem 'sass', '~> 3.4.18'
gem 'sprockets', '~> 3.3.4'

gem 'sprockets-helpers'
gem 'rabl', '~> 0.11.6'
gem 'rack-contrib'
gem 'kramdown', '1.9.0'
gem 'warden', '~> 1.2.4'
gem 'encrypted_cookie'
gem 'git'

group :production do
  gem 'passenger'
  gem 'pg'
end

group :development do
  gem 'shotgun'
  gem 'tux'
  gem 'pry'
  gem 'pry-byebug'
end

group :test, :development do
  gem 'minitest', '~> 5.0'
  gem 'minitest-hooks'
  gem "rack-test"
  gem "factory_girl"
  gem "database_cleaner"
  gem "minitest-around"
  gem "dm-sqlite-adapter"
  gem "mocha"
end
