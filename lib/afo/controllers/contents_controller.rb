require 'api'

module Afo
  class ContentsController < Api

    get "/:id" do
      @content = find_resource
      render_resource
    end

    put "/:id" do
      @content = find_resource
      if @content.save
        render_resource
      else
        render_validation_errrors
      end
    end
  end
end