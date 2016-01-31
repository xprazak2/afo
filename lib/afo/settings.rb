require 'yaml'
require 'settings_loader'

module Afo
  class Settings

    def self.[](item)
      @@settings[item]
    end

    @@settings ||= Afo::SettingsLoader.new.load
  end
end
