require 'test_helper'

module Afo
  class ComicsControllerTest < Afotest::Test
    include Rack::Test::Methods
    include Afo::ComicsControllerCommon

    def app
      Afo::ComicsController
    end

    def setup
      @comic = FactoryGirl.create(:comic)
      @comic_2 = FactoryGirl.create(:comic, :title => "second")
      Afo::Comic.any_instance.stubs(:load_file).returns("loaded")
      Afo::Comic.any_instance.stubs(:file).returns("loaded")
      super
    end

    def test_create
      Afo::Comic.any_instance.expects(:save_file).returns(true)
      post "/", { :comic => { :title => "test comic", :name => "test.png", :file => "ibah6b" }}
      assert last_response.ok?
      data = JSON.parse(last_response.body)
      assert data["id"]
    end

    def test_create_fail
      Afo::Comic.any_instance.expects(:save_file).returns(true).never
      post "/", { :comic => { :title => "test comic", :name => "test.png" }}
      assert_equal 422, last_response.status
      data = JSON.parse(last_response.body)
      assert_equal "No comic file supplied!", data["message"]
    end

    def test_delete
      Afo::Comic.any_instance.expects(:delete_file)
      delete "/#{@comic.id}", { :id => @comic.id }
      assert_equal 200, last_response.status
      refute Afo::Comic.all.include?(@comic)
    end
  end
end