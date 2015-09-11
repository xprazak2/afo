module Afo
  class PublicContent < ::Sinatra::Base

    get '/' do
      c = Comic.new
      c.log_me
      erb :'public/index'
    end

  end
end