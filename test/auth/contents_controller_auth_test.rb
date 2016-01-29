require 'test_helper'

module Afo
  class ContentsControllerAuthTest < Minitest::Test
    include Rack::Test::Methods

    def app
      Afo::ContentsController
    end

    def test_update
      @content = FactoryGirl.create(:content)
      params = {:id => @content.id, :content => {:title => "new title", :content => "very pretty"}}
      put "/#{@content.id}", params
      assert_equal 401, last_response.status
      data = JSON.parse(last_response.body)
      assert_equal 'Not authenticated', data["error"]
    end
  end
end
