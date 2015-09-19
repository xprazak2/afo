require 'api'

module Afo
  class UsersController < Api

    get "/" do
      @users = User.all
      rabl :'users/index', :format => :json
    end

   get "/:id" do
      find_user
      rabl :'users/show', :format => :json
    end

    put "/:id" do
      find_user
      rabl :'users/show', :format => :json
    end

    private

    def find_user
      halt(500, rabl(:'users/error', :format => :json)) unless params[:id]
      @user = User.get params[:id] || halt(500, rabl(:'users/error', :format => :json))
    end
  end
end