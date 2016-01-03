require 'api'

module Afo
  class ContentsController < Api

    get "/:id" do
      @content = find_resource
      render_resource
    end

    put "/:id" do
      @content = find_resource
      if @content.update params[:content]
        render_resource
      else
        render_validation_errors
      end
    end

    post "/" do
      @content = Content.new params[:content]
      if @content.save
        render_resource
      else
        render_validation_errors
      end
    end
  end
end