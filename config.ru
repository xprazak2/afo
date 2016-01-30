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

#using encrypted cookie instead of this
#use Rack::Session::Cookie, :key => '_rack_session',
#                           :path => '/',
#                           :expire_after => 2592000, # In seconds
#                           :secret => 'asdfa2342923422f1adc05c837fa234230e3594b93824b00e930ab0fb94b'

use Rack::Session::EncryptedCookie, :secret => 'sdfa2342923422f1adc05c837fa234230e3594b93824b00e930ab0fb94bad58baf86ea5', :httponly => true
use Rack::Protection
use Rack::PostBodyContentTypeParser
use Middleware::Assets

map "/api/contents" do
  run Afo::ContentsController
end

map "/api/users" do
  run Afo::UsersController
end

map "/api/comics" do
  run Afo::ComicsController
end

map "/" do
  run Afo::PublicController
end

map "/private" do
  run Afo::PrivateController
end