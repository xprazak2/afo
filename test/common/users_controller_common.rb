module Afo
  module UsersControllerCommon
    def test_index
      get '/'
      assert last_response.ok?
      data = JSON.parse(last_response.body)
      assert data.map { |item| item["name"] }.include?(@user.name)
    end

    def test_get_user
      get "/#{@user.id}"
      assert last_response.ok?
      data = JSON.parse(last_response.body)
      assert_equal @user.name, data["name"]
      assert_equal @user.id, data["id"]
    end

    def test_get_user_fail
      get "/-10"
      assert_equal 422, last_response.status
      data = JSON.parse(last_response.body)
      assert_equal "could not find user with id -10", data["message"]
    end
  end
end