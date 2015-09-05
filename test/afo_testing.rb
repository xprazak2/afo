require 'sinatra/base'
require 'data_mapper'

$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib', 'afo'))

APP_ROOT = "#{File.dirname(__FILE__)}/.."

module Afo
  ::Sinatra::Base.set :run, false
  
  #data model related
  require 'settings'
  require 'user'
  DataMapper.setup(:default, 'sqlite::memory:')
  DataMapper.finalize.auto_upgrade!  
end