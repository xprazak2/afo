module Afo
  class PrivateContent < ::Sinatra::Base

    get '/?' do 
      erb :'private/index'
    end

  end
end