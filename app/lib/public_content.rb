require_relative 'base'

module Afo
  class PublicContent < Base

    get '/' do
      erb :'public/index'
    end

  end
end