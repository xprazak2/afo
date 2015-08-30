require File.join(File.dirname(__FILE__), 'afo.rb')

map "/" do
  run Afo::PublicContent
end

map "/private" do
  run Afo::PrivateContent
end