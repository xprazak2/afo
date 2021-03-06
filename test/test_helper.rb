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

require 'common/comics_controller_common'
require 'common/contents_controller_common'
require 'common/users_controller_common'

module Afotest
  class Test < Minitest::Test
    include Minitest::Hooks
    include Warden::Test::Helpers

    def setup
      super
      login_as @admin
    end

    def before_all
      super
      @admin = FactoryGirl.create(:user)
    end

    def admin
      @admin
    end

    def teardown
      logout
      Warden.test_reset!
      super
    end
  end
end
