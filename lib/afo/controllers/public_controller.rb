module Afo
  class PublicContent < ::Sinatra::Base

    helpers do
      include Sprockets::Helpers
    end

    get '/' do
      erb :'public/index'
    end

  end
end