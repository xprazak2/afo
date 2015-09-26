require 'api'

module Afo
  class UsersController < Api

    get "/" do
      @users = User.all
      render_index
    end

   get "/:id" do
      @user = find_resource
      render_resource
    end

    put "/:id" do
      @user = find_resource
      binding.pry
      begin
        @user.save
        puts "ole"
        render_resource
      rescue
        render_validation_errors
      end
    end

    private

    def find_user
      halt(500, rabl(:'users/error', :format => :json)) unless params[:id]
      @user = User.get params[:id] || halt(500, rabl(:'users/error', :format => :json))
    end
  end
end