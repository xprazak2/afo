module Afo
  module ComicsControllerCommon
    def test_index
      get '/'
      assert last_response.ok?
      data = JSON.parse(last_response.body)
      assert data.map { |item| item['title'] }.include?(@comic.title)
    end

    def test_get
      get "/#{@comic.id}"
      assert last_response.ok?
      data = JSON.parse(last_response.body)
      assert_equal @comic.title, data["title"]
    end
  end
end
