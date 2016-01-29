require 'test_helper'

module Afo
  class ComicsControllerAuthTest < Minitest::Test
    include Rack::Test::Methods

    def app
      Afo::ComicsController
    end

    def test_create
      Afo::Comic.any_instance.expects(:save_file).never
      accept_json = {"Accept" => "application/json", "CONTENT_TYPE" => "application/json" }
      post "/", { :comic => { :title => "test comic", :name => "test.png", :file => "ibah6b" }}, accept_json
      assert_equal 401, last_response.status
      data = JSON.parse(last_response.body)
      assert_equal 'Not authenticated', data["error"]
    end

    def test_delete
      @comic = FactoryGirl.create(:comic)
      Afo::Comic.any_instance.expects(:delete_file).never
      delete "/#{@comic.id}", { :id => @comic.id }
      assert_equal 401, last_response.status
      data = JSON.parse(last_response.body)
      assert_equal 'Not authenticated', data["error"]
    end
  end
end
