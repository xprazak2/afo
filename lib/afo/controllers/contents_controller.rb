require 'api'

module Afo
  class ContentsController < Api

    before do
      @content = Content.get params[:id] if params[:id]
    end

    get "/:id" do
      @content = Content.get params[:id]
      rabl :'contents/show', :format => :json
    end

    put "/:id" do
      if @content.save
        rabl :'contents/show', :format => :json
      else
        rabl :'common/error', :format => :json
      end
    end

  end
end