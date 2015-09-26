require 'api'

module Afo
  class ComicsController < Api

    get "/" do

    end

    get "/:id" do

    end

    put "/:id" do

    end

    post "/" do

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