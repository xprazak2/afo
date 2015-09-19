require "settings"
require "user"
require "logging"
include Afo::Logging

users = Afo::User.all

Afo::Settings[:admins].each do |a|
  Afo::User.first_or_create({:username => a[:username]}, a)
  users.delete_if { |user| user.username == a[:username] }
end

users.each do |u|
  logger.warn "Found non-whitelisted user #{u.username}, created at #{u.created_at}, deleting..."
  u.destroy!
end