require 'sinatra/base'
require 'data_mapper'

APP_ROOT = "#{File.dirname(__FILE__)}/.."
$:.unshift(File.join(APP_ROOT, 'lib', 'afo'))
$:.unshift(File.join(APP_ROOT, 'config'))

module Afo
  ::Sinatra::Base.set :run, false
  
  #data model related
  # require 'settings'
  require 'user'
  DataMapper.setup(:default, 'sqlite::memory:')
  DataMapper.finalize.auto_upgrade!  
end