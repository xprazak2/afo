require 'yaml'
require 'logging'

module Afo
  class Settings
    extend Afo::Logging

    def self.[](item)
      @@settings[item]
    end

    if ENV['RACK_ENV'] != 'test'
      if File.exists?("#{APP_ROOT}/config/settings.yml")
        @@settings = YAML.load_file("#{APP_ROOT}/config/settings.yml")
      else
        @@settings = YAML.load_file("#{APP_ROOT}/config/settings.defaults.yml")
        logger.warn "Cannot find config/settings.yml file, starting with defaults"
      end
    else
      @@settings = { :log_level => 'DEBUG' }
    end
  end
end
