require 'sinatra/base'

module Afo
  class Base < Sinatra::Base
    # set :static, true
    set :public_folder, File.join(File.dirname(__FILE__),'public')
    enable :sessions
  end

  class PublicContent < Base
    set :views, File.join(File.dirname(__FILE__), 'views', 'public')

    get '/' do
      erb :index
    end
  end

  class PrivateContent < Base
    set :views, File.join(File.dirname(__FILE__), 'views', 'private')

    get '/?' do 
      erb :private
    end

    
  end
end