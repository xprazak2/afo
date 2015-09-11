APP_ROOT = "#{File.dirname(__FILE__)}/.."
$:.unshift(File.dirname(__FILE__) + '/afo')
$:.unshift(APP_ROOT + '/public')

require 'sinatra/base'
require 'sinatra-initializers'
require 'data_mapper'
require 'dm-timestamps'

module Afo
  
  ::Sinatra::Base.set :run, false
  ::Sinatra::Base.set :root, APP_ROOT
  ::Sinatra::Base.set :views, APP_ROOT + '/views'
  ::Sinatra::Base.set :public_folder, APP_ROOT + '/public'
  
  require 'settings'  
  require 'logging'

  # ::Sinatra::Base.set :logging, false
  ::Sinatra::Base.use Rack::CommonLogger, ::Afo::Logging.file
  # ::Sinatra::Base.use ::Afo::LoggingMiddleware
  
  
  DataMapper::Resource.send :include, Logging     
  models = %w(user comic content)
  models.each {|model| require model}

  DataMapper.setup(:default,
                   "postgres://#{Settings[:db_user]}:#{Settings[:db_password]}@#{Settings[:db_path]}")
  DataMapper.finalize.auto_upgrade!

  ::Sinatra::Base.configure(:development) do
    require 'pry'
    require 'pry-byebug'
    DataMapper::Logger.new($stdout, :debug)
  end

  ::Sinatra::Base.configure(:production) do
  # 
  end

  ::Sinatra::Base.configure do |s|
    # s.enable :logging
    # file = File.new("#{APP_ROOT}/config/#{s.settings.environment}.log", 'a+')
    # file.sync = true
    # s.use LoggingMiddleware
    # s.use Rack::CommonLogger, Logging.logger
    # s.before { env["rack.errors"] = Logging.logger }
    s.register Sinatra::Initializers
  end
end