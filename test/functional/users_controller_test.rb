require 'test_helper'

module Afo
  class UsersControllerTest < MiniTest::Unit::TestCase

    include Rack::Test::Methods

    def app
      Afo::UsersController
    end

    def setup
      @user = FactoryGirl.create("user")
    end

    def test_index
      get '/'
      assert last_response.ok?
      data = JSON.parse(last_response.body)
      assert_equal @user.username, data.first["username"]
    end

    def test_get_user
      get "/#{@user.id}"
      assert last_response.ok?
      data = JSON.parse(last_response.body)
      assert_equal @user.username, data["username"]
      assert_equal @user.id, data["id"]
    end

    def test_get_user_fail
      get "/10"
      assert_equal 422, last_response.status
      data = JSON.parse(last_response.body)
      assert_equal "could not find user with id 10", data["message"]
    end

    def test_put_user
      params = {:id => @user.id, :user => {:id => @user.id,
                                           :username => "administrator",
                                           :password => "changeme_really"}}
      put "/#{@user.id}", params
      assert last_response.ok?
      data = JSON.parse(last_response.body)
      assert_equal "administrator", data["username"]
    end

    def test_put_user_fail
      params = {:id => @user.id, :user => {:id => @user.id,
                                           :username => "a",
                                           :password => "changeme_really"}}
      put "/#{@user.id}", params
      assert_equal 422, last_response.status
      data = JSON.parse(last_response.body)
      assert_equal "Username must be at least 4 characters long", data["errors"].first["username"].first
    end
  end
end