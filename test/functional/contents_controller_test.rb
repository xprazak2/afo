require 'test_helper'

module Afo
  class ContentsControllerTest < Afotest::Test

    include Rack::Test::Methods

    def app
      Afo::ContentsController
    end

    def setup
      @content = FactoryGirl.create(:content)
      super
    end

    def test_get_content
      get "/#{@content.id}"
      assert last_response.ok?
      data = JSON.parse(last_response.body)
      assert_equal @content.content, data["content"]
    end

    def test_get_content_fail
      get "/10"
      assert_equal 422, last_response.status
      data = JSON.parse(last_response.body)
      assert_equal "could not find content with id 10", data["message"]
    end

    def test_put_content
      params = {:id => @content.id, :content => {:title => "new title", :content => "very pretty"}}
      put "/#{@content.id}", params
      assert last_response.ok?
      data = JSON.parse(last_response.body)
      assert_equal params[:content][:title], data["title"]
    end

  end
end