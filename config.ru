#require all Sinatra::Base descandants in our app
app_dir = File.join(File.dirname(__FILE__), 'lib')
require File.join(app_dir, 'afo.rb')
Dir["#{app_dir}/afo/*content.rb"].each { |file| require file }

map "/" do
  run Afo::PublicContent
end

map "/private" do
  run Afo::PrivateContent
end