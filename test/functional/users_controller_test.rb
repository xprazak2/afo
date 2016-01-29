require 'test_helper'

module Afo
  class UsersControllerTest < Afotest::Test
    include Rack::Test::Methods
    include Afo::UsersControllerCommon

    def app
      Afo::UsersController
    end

    def setup
      @user = FactoryGirl.create("user")
      super
    end

    def test_update_user
      params = {:id => @admin.id, :user => {:id => @admin.id,
                                           :name => "administrator",
                                           :password => "changeme_really"}}
      put "/#{@admin.id}", params
      assert last_response.ok?
      data = JSON.parse(last_response.body)
      assert_equal "administrator", data["name"]
    end

    def test_update_user_fail
      params = {:id => @admin.id, :user => {:id => @admin.id,
                                           :name => "a",
                                           :password => "changeme_really"}}
      put "/#{@user.id}", params
      assert_equal 422, last_response.status
      data = JSON.parse(last_response.body)
      assert_equal "Name must be at least 4 characters long", data["errors"].first["name"].first
    end

    def test_update_different_user
      params = {:id => @user.id, :user => {:id => @user.id,
                                           :name => "new_admin_user",
                                           :password => "changeme_really"}}
      put "/#{@user.id}", params
      assert_equal 401, last_response.status
      data = JSON.parse(last_response.body)
      assert_equal 'Not authenticated', data["error"]
    end
  end
end
