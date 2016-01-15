require 'application_controller'

module Afo
  class PrivateController < ApplicationController

    helpers do
      include Sprockets::Helpers
    end

    get '/?' do
      erb :'private/index'
    end

    post '/login' do
      warden.authenticate!
      if current_user
        redirect '/'
      else
        redirect '/private'
      end
    end

  end
end