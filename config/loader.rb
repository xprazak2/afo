require 'uri'

module Afo
  class Loader
    def initialize(settings)
      @settings = settings
    end

    def load_db_config
      begin
        @uri = URI.parse(ENV["DATABASE_URL"])
      rescue URI::InvalidURIError
        raise "Invalid DATABASE_URL"
      end
      @settings[:db_user] = @uri.user
      @settings[:db_password] = @uri.password
      @settings[:db_path] = @uri.path
    end
  end
end