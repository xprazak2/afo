module Afo
  class PublicContent < ::Sinatra::Base

    get '/' do
      erb :'public/index'
    end

  end
end