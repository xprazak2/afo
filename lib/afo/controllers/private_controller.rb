require 'application_controller'
require 'json'

module Afo
  class PrivateController < ApplicationController

    helpers do
      include ::Sprockets::Helpers
    end

    get '/?' do
      erb :'private/index'
    end

    post '/login' do
      warden.authenticate!
      redirect '/'
    end

    get '/logout' do
      warden.logout
      content_type :json
      { message: "OK" }.to_json
    end

    post '/unauthenticated/?' do
      redirect '/private', 401
    end
  end
end