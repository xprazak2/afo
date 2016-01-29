ENV['RACK_ENV'] = 'test'

require "minitest/autorun"
require 'minitest/unit'
require 'minitest/hooks/test'
require 'mocha/mini_test'

$: << File.join(File.dirname(__FILE__), '..', 'lib')

require "afo_testing"
require 'rack/test'
require 'factory_girl_init'
require 'factories'

module Afotest
  class Test < Minitest::Test
    include Minitest::Hooks
    include Warden::Test::Helpers

    def setup
      super
      login_as @user
    end

    def before_all
      super
      @user = Afo::User.create(:name => "TestUser", :password => "changeme")
    end

    def teardown
      logout
      Warden.test_reset!
      super
    end

    def after_all
      @user.destroy
      super
    end
  end
end
