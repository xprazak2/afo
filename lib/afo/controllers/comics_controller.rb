require 'api'

module Afo
  class ComicsController < Api

    get "/" do
      @comics = Comic.all
      render_index
    end

    get "/:id" do
      #all in one(???) vs. 2 requests for file and data
    end

    put "/:id" do
      #preliminary solution
      @comic = find_resource
      @comic.file = params[:file]
      begin
        @comic.save
        render_resource
      rescue => e
        render_error
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

  end
end