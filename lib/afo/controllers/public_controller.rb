module Afo
  class PublicContent < ::Sinatra::Base

    helpers do
      include Sprockets::Helpers
    end

    def self.pages
      ['/', '/about', '/disclaimer', /\d+/, "/comics/new", "/comics/list"]
    end

    pages.each do |page|
      get page do
        erb :'public/index'
      end
    end
  end
end