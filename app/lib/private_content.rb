require_relative 'base'

module Afo
  class PrivateContent < Base

    get '/?' do 
      erb :'private/index'
    end

  end
end