require 'api'

module Afo
  class ComicsController < Api

    get "/" do
      #not handling when there are comic files missing
      @comics = Comic.all
      render_index
    end

    get "/:id" do
      @comic = find_resource
      handle_response
    end

    put "/:id" do
      #preliminary solution
      @comic = find_resource
      @comic.file = params[:file]
      begin
        @comic.save
        render_resource
      rescue => e
        render_error e.message
      end
    end

    post "/" do
      #preliminary solution
      @comic = Comic.new params[:comic]
      @comic.file = params[:file]
      begin
        @comic.save
        render_resource
      rescue => e
        render_error
      end
    end

    delete "/:id" do
      @comic = find_resource
      begin
        @comic.destroy
        render_resource
      rescue => e
        render_error e.message
      end
    end

    private

    def handle_response
      if @comic.file
        render_resource
      else
        render_error "Could not find comic file on the server."
      end
    end

  end
end