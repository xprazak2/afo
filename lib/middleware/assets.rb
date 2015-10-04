require 'sinatra/base'
require 'sprockets'
require 'sprockets-helpers'

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

      ::Sprockets::Helpers.configure do |config|
        config.environment = assets
        config.prefix = "/assets"
        config.digest = false
        config.public_path = public_folder
        config.debug = true if development? #do not turn on, causes stylesheet load to fail!!!
      end
    end

  get "/assets/:file.js" do
    content_type("application/javascript")
    settings.assets["#{params[:file]}.js"]
  end

  get "/assets/:file.css" do
    content_type("text/css")
    settings.assets["#{params[:file]}.css"]
  end

  # %w{jpg png}.each do |format|
  #   get "/assets/:image.#{format}" do |image|
  #     content_type("image/#{format}")
  #     settings.assets["#{image}.#{format}"]
  #   end
  # end

  end
end