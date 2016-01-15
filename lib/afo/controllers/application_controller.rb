module Afo
  class ApplicationController < ::Sinatra::Base
    enable :sessions
    set :session_secret, "top_secret"

    ::Warden::Strategies.add(:password) do
      def valid?
        params['user'] && params['user']['name'] && params['user']['password']
      end

      def authenticate!
        user = User.authenticate(params['user']['name'], params['user']['password'])
        binding.pry
        if user.nil?
          pass
        else
          success!(user)
        end
      end
    end

    use Warden::Manager do |config|
      config.serialize_into_session { |user| user.id }
      config.serialize_from_session { |id| User.get id }
      config.default_strategies :password
      config.failure_app = Afo::PrivateController
    end

    Warden::Manager.before_failure do |env, opts|
      env['REQUEST_METHOD'] = 'POST'
    end

    def warden
      env['warden']
    end

    def current_user
      warden.user
    end
  end
end