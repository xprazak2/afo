app_dir = File.join(File.dirname(__FILE__), 'lib')

#require main app file
require File.join(app_dir, 'afo.rb')

#require rendering
require File.join(app_dir, 'afo', 'rendering.rb')

#require all Sinatra::Base descandants in our app
Dir["#{app_dir}/afo/controllers/*.rb"].each { |file| require file }

#require asset middleware
require File.join(app_dir, 'middleware', 'assets.rb')

require 'rack/contrib'

use Rack::PostBodyContentTypeParser
use Middleware::Assets

map "/api" do
  run Afo::Api
end

map "/api/contents" do
  run Afo::ContentsController
end

map "/api/users" do
  run Afo::UsersController
end

map "/" do
  run Afo::PublicContent
end

map "/private" do
  run Afo::PrivateContent
end