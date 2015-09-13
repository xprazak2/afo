require 'sinatra/base'
require 'sprockets'

module Middleware
  class Assets < Sinatra::Base
    configure do
      set :assets, (::Sprockets::Environment.new { |env|
        # env.append_path(settings.root + "/assets/images")
        env.append_path(settings.root + "/public/js")
        env.append_path(settings.root + "/public/css")

        # compress everything in production
        # if ENV["RACK_ENV"] == "production"
        #   env.js_compressor  = YUI::JavaScriptCompressor.new
        #   env.css_compressor = YUI::CssCompressor.new
        # end
      })
    end

  get "/assets/afo.js" do
    content_type("application/javascript")
    settings.assets["afo.js"]
  end

  get "/assets/afo.css" do
    content_type("text/css")
    settings.assets["afo.css"]
  end

  # %w{jpg png}.each do |format|
  #   get "/assets/:image.#{format}" do |image|
  #     content_type("image/#{format}")
  #     settings.assets["#{image}.#{format}"]
  #   end
  # end

  end
end