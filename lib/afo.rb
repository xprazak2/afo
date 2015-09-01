APP_ROOT = "#{File.dirname(__FILE__)}/.."

require 'sinatra/base'
  
module Afo

  ::Sinatra::Base.set :run, false
  ::Sinatra::Base.set :root, APP_ROOT
  ::Sinatra::Base.set :views, APP_ROOT + '/views'
  ::Sinatra::Base.set :public_folder, APP_ROOT + '/public'
  
  puts "Loading Afo..."
  ::Sinatra::Base.configure(:development) do
    require 'pry'
    require 'pry-byebug'
    puts "Afo running in devel mode"
  end 

  ::Sinatra::Base.configure(:production) { puts "Afo running in production mode" } 

end