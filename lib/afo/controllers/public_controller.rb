require 'application_controller'

module Afo
  class PublicController < ApplicationController

    helpers do
      include Sprockets::Helpers
    end

    def self.pages
      ['/', '/about', '/disclaimer', /\d+/, "/comics/new", "/comics"]
    end

    pages.each do |page|
      get page do
        erb :'public/index'
      end
    end
  end
end