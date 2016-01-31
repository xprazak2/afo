require 'uri'
require 'logging'

module Afo
  class SettingsLoader
    include Afo::Logging

    def initialize
      @settings = {}
      @settings_dir = './config/settings.d'
    end

    #each loaded file can overwrite setting values from previously loaded files
    def load
      ["settings.defaults.yml",
       "settings.#{Afo.env}.yml",
       "settings.common.yml",
       "settings.local.yml"
     ]
     .each { |filename| load_file filename }
     load_production_db_config if Afo.env == 'production'
     logger.debug "Initialized with settings:"
     logger.debug @settings
     @settings
    end

    def by_name(filename)
      "#{@settings_dir}/#{filename}"
    end

    def load_file(filename)
      filename = by_name filename
      if File.exists? filename
        logger.debug "Loading settings file #{filename}"
        @settings.merge! YAML.load_file(filename)
      else
        logger.warn "Cannot find #{filename} file, skipping"
      end
    end

    def load_production_db_config
      begin
        @uri = URI.parse(ENV["DATABASE_URL"])
      rescue URI::InvalidURIError
        raise "Invalid DATABASE_URL"
      end
      @settings[:db_user] = @uri.user
      @settings[:db_password] = @uri.password
      @settings[:db_path] = "#{@uri.host}:#{@uri.port}/#{@uri.path}"
    end
  end
end