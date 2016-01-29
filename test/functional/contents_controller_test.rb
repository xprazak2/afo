require 'test_helper'

module Afo
  class ContentsControllerTest < Afotest::Test
    include Rack::Test::Methods
    include Afo::ContentsControllerCommon

    def app
      Afo::ContentsController
    end

    def setup
      @content = FactoryGirl.create(:content)
      super
    end

    def test_update
      params = { :id => @content.id, :content => { :title => "new title", :content => "very pretty" }}
      put "/#{@content.id}", params
      assert last_response.ok?
      data = JSON.parse(last_response.body)
      assert_equal params[:content][:title], data["title"]
    end
  end
end
