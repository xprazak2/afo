require 'test_helper'

module Afo
  class ComicsControllerTest < MiniTest::Unit::TestCase
    include Rack::Test::Methods

    def app
      Afo::ComicsController
    end

    def setup
      @comic = FactoryGirl.create(:comic)
      @comic_2 = FactoryGirl.create(:comic, :title => "second")
      Afo::Comic.any_instance.stubs(:load_file).returns("loaded")
      Afo::Comic.any_instance.stubs(:file).returns("loaded")
    end

    def test_index
      get '/'
      assert last_response.ok?
      data = JSON.parse(last_response.body)
      assert_equal @comic.title, data.first["title"]
    end

    def test_get
      get "/#{@comic.id}"
      assert last_response.ok?
      data = JSON.parse(last_response.body)
      assert_equal @comic.title, data["title"]
    end

    # def test_delete
    #   @comic.expects(:delete_file)
    #   delete "/#{@comic.id}", {:id => @comic.id}
    #   assert_equal 200, last_response.status
    #   refute Afo::comic.all.include?(@comic)
    # end

  end
end