require 'logger'

Logger.class_eval { alias_method :write, :info }

module Afo
  module Logging
    @@logger = nil
    @@file = nil
    
    def logger
      @@logger ||= ::Afo::Logging.logger
    end

    def self.file
      unless @@file
        @@file = File.new("#{APP_ROOT}/config/#{::Sinatra::Base.settings.environment}.log", "a+")
        @@file.sync = true
      end
      @@file
    end

    def self.logger
      env = ::Sinatra::Base.settings.environment
      file = env == :development ? STDOUT : @@file
      logger = ::Logger.new(file)
      logger.level = ::Logger.const_get(Afo::Settings[:log_level].upcase)
      logger
    end
  end

  #is not needed at the present, kept just for reference, probably will be removed in the future
  class LoggingMiddleware
    include Logging

    def initialize(app)
      @app = app
    end

    def call(env)
      env['rack.logger'] = logger
      @app.call(env)
    end
  end
  #
end