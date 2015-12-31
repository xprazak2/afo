require 'api'

module Afo
  class ComicsController < Api

    get "/" do
      #not handling when there are comic files missing since we are using 'light' view w-o comic files
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
      begin
        @comic.save
        render_resource
      rescue => e
        render_error e.message
      end
    end

    post "/" do
      @comic = Comic.new params[:comic]
      begin
        raise "Original file name with extension not supplied" unless params[:comic][:name]
        raise "No comic file supplied!" unless params[:comic][:file]
        @comic.save
        render_resource
      rescue => e
        render_error e.message
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