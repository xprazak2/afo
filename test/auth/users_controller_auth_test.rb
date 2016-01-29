require 'test_helper'

module Afo
  class UsersControllerAuthTest < Minitest::Test
    include Rack::Test::Methods
    include Afo::UsersControllerCommon

    def app
      Afo::UsersController
    end

    def setup
      @user = FactoryGirl.create("user")
    end

    def test_update_user
      params = {:id => @user.id, :user => {:id => @user.id,
                                           :name => "administrator",
                                           :password => "changeme_really"}}
      put "/#{@user.id}", params
      assert_equal 401, last_response.status
      data = JSON.parse(last_response.body)
      assert_equal 'Not authenticated', data["error"]
    end
  end
end