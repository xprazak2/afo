require 'test_helper'

module Afo
  class ComicsControllerTest < MiniTest::Unit::TestCase
    include Rack::Test::Methods

    def app
      Afo::ComicsController
    end

    def setup
      # @comic.stubs(:ext).returns(".png")
      # @comic.stubs(:save_file)
      @comic = FactoryGirl.create(:comic)
    end

    def test_index
      get '/'
      assert last_response.ok?
      data = JSON.parse(last_response.body)
      assert_equal @comic.title, data.first["title"]
    end

    # def test_delete
    #   @comic.expects(:delete_file)
    #   delete "/#{@comic.id}", {:id => @comic.id}
    #   assert_equal 200, last_response.status
    #   refute Afo::comic.all.include?(@comic)
    # end

  end
end