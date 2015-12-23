require "settings"
require "user"
require "logging"
include Afo::Logging

users = Afo::User.all

Afo::Settings[:admins].each do |a|
  Afo::User.first_or_create({:name => a[:name]}, a)
  users.delete_if { |user| user.name == a[:name] }
end

users.each do |u|
  logger.warn "Found non-whitelisted user #{u.name}, created at #{u.created_at}, deleting..."
  u.destroy!
end