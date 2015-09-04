APP_ROOT = "#{File.dirname(__FILE__)}/.."

require 'sinatra/base'
require 'data_mapper'

module Afo
  ::Sinatra::Base.set :run, false
  ::Sinatra::Base.set :root, APP_ROOT
  ::Sinatra::Base.set :views, APP_ROOT + '/views'
  ::Sinatra::Base.set :public_folder, APP_ROOT + '/public'

  ::Sinatra::Base.configure do |s|
    s.enable :logging
    file = File.new("#{APP_ROOT}/config/#{s.settings.environment}.log", 'a+')
    file.sync = true
    s.use Rack::CommonLogger, file

    s.before {
      env["rack.errors"] =  file
    }
  end

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

  require_relative 'settings'

  DataMapper.setup(:default,
                   "postgres://#{Settings[:db_user]}:#{Settings[:db_password]}@#{Settings[:db_path]}")

  require_relative 'user'
  DataMapper.finalize.auto_upgrade!
end