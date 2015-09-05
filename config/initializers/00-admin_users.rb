require "settings"
require "user"

Afo::Settings[:admins].each do |a|
  Afo::User.first_or_create({:username => a[:username]}, a)
end