require 'sinatra/base'
require 'data_mapper'

APP_ROOT = "#{File.dirname(__FILE__)}/.."
$:.unshift(File.join(APP_ROOT, 'lib', 'afo'))
$:.unshift(File.join(APP_ROOT, 'config'))
$:.unshift(File.join(APP_ROOT, 'lib', 'afo', 'controllers'))

module Afo
  ::Sinatra::Base.set :run, false
  ::Sinatra::Base.set :public_folder, APP_ROOT + '/public'
  ::Sinatra::Base.set :views, APP_ROOT + '/views'

  require 'json'
  #data model related
  require 'logging'
  require 'settings'
  require 'kramdown'
  require 'warden'
  DataMapper::Resource.send :include, Logging
  require 'user'
  require 'comic'
  require 'content'
  require 'error'

  DataMapper.setup(:default, 'sqlite::memory:')
  DataMapper.finalize.auto_upgrade!

  require 'rendering'
  require 'api_controller'
  require 'users_controller'
  require 'contents_controller'
  require 'comics_controller'
  require 'private_controller'
end
