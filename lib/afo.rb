APP_ROOT = "#{File.dirname(__FILE__)}/.."
$:.unshift(File.dirname(__FILE__) + '/afo')

require 'sinatra/base'
require 'sinatra-initializers'
require 'data_mapper'

module Afo
  ::Sinatra::Base.set :run, false
  ::Sinatra::Base.set :root, APP_ROOT
  ::Sinatra::Base.set :views, APP_ROOT + '/views'
  ::Sinatra::Base.set :public_folder, APP_ROOT + '/public'


  require 'settings'
  require 'user'
  DataMapper.setup(:default,
                   "postgres://#{Settings[:db_user]}:#{Settings[:db_password]}@#{Settings[:db_path]}")
  DataMapper.finalize.auto_upgrade!

  puts "Loading Afo..."
  ::Sinatra::Base.configure(:development) do
    require 'pry'
    require 'pry-byebug'
    puts "Afo running in devel mode"
    DataMapper::Logger.new($stdout, :debug)
  end

  ::Sinatra::Base.configure(:production) do
    puts "Afo running in production mode"
  end

  ::Sinatra::Base.configure do |s|
    s.enable :logging
    file = File.new("#{APP_ROOT}/config/#{s.settings.environment}.log", 'a+')
    file.sync = true
    s.use Rack::CommonLogger, file

    s.before {
      env["rack.errors"] =  file
    }

    s.register Sinatra::Initializers
  end
end