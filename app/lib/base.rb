module Afo
  class Base < Sinatra::Base
    # set :static, true
    set :views, File.join(File.dirname(__FILE__), '..', 'views')
    set :public_folder, File.join(File.dirname(__FILE__), '..', 'public')
    enable :sessions
  end
end