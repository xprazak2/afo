module Afo
  class ApplicationController < ::Sinatra::Base
    ::Warden::Strategies.add(:password) do
      def valid?
        params['user'] && params['user']['name'] && params['user']['password']
      end

      def authenticate!
        user = User.authenticate(params['user']['name'], params['user']['password'])
        if user.nil?
          fail!("Could not log in")
        else
          success!(user)
        end
      end
    end

    use Warden::Manager do |config|
      config.serialize_into_session { |user| user.id }
      config.serialize_from_session { |id| User.get id }
      config.scope_defaults :default,
                            :strategies => [:password],
                            :action => 'unauthenticated'
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