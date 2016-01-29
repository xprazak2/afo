require 'sinatra/base'
require 'sprockets'
require 'sprockets-helpers'

module Middleware
  class Assets < Sinatra::Base
    configure do
      set :assets, (::Sprockets::Environment.new { |env|
        env.append_path(settings.root + "/public/js")
        env.append_path(settings.root + "/public/css")
        env.append_path(settings.root + "/public/images")

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
        # config.expand = true # we cannot expand because sprockets add .self to asset path making it fail
        config.public_path = public_folder
        # config.debug = true if development? #do not turn on, sprockets bug causes asset load failure
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

  get "/*/views/:file.html" do
    angular_modules = %w(comics contents layout users directives services)
    halt 404, 'No assets on this route' unless angular_modules.include? params['splat'].first
    content_type("text/html")
    path = [settings.assets.paths.first, params[:splat], "views", "#{params[:file]}.html"].join("/")
    send_file File.join(settings.assets.paths.first, params[:splat], "views", "#{params[:file]}.html")
  end

  %w{svg}.each do |format|
    get "/assets/:image.#{format}" do |image|
      content_type("image/#{format}")
      settings.assets["#{image}.#{format}"]
    end
  end

  end
end
