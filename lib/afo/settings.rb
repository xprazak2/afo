require 'yaml'

module Afo
  class Settings

    if ENV['RACK_ENV'] != 'test'
      if File.exists?("#{APP_ROOT}/config/settings.yml")
        @@settings = YAML.load_file("#{APP_ROOT}/config/settings.yml")
      else
        raise "Cannot load settings, make sure there is a /config/settings.yml file."
      end
    else
      @@settings = { :log_level => 'DEBUG' }
    end

    def self.[](item)
      @@settings[item]
    end
  end
end