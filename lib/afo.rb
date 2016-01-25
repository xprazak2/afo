APP_ROOT = "#{File.dirname(__FILE__)}/.."
AFO = File.dirname(__FILE__) + '/afo'

#load the files in afo subdirectories
Dir.entries(AFO).select do |entry|
  File.directory? File.join(AFO, entry) and !(entry =='.' || entry == '..')
end.map do |folder_name|
 File.join AFO, folder_name
end.each do |folder|
  $:.unshift(folder)
end

$:.unshift(AFO)
$:.unshift(APP_ROOT + '/public')
$:.unshift(APP_ROOT + '/config')

require 'sinatra/base'
require 'sinatra-initializers'
require 'data_mapper'
require 'dm-timestamps'
require 'tilt/erb'
require 'sass'
require 'sprockets-helpers'
require 'active_support/all'
require 'kramdown'
require 'warden'

module Afo

  ::Sinatra::Base.set :run, false
  ::Sinatra::Base.set :root, APP_ROOT
  ::Sinatra::Base.set :views, APP_ROOT + '/views'
  ::Sinatra::Base.set :public_folder, APP_ROOT + '/public'

  require 'version'
  require 'settings'
  require 'logging'
  ::Sinatra::Base.use Rack::CommonLogger, ::Afo::Logging.file

  DataMapper::Resource.send :include, Logging
  models = %w(user comic content error)
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
    s.register Sinatra::Initializers
  end
end