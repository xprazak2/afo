module Afo
  module ContentsControllerCommon
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
  end
end