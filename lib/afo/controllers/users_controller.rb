require 'api_controller'

module Afo
  class UsersController < ApiController

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
      begin
        @user.update params[:user]
        render_resource
      rescue
        render_validation_errors
      end
    end
  end
end