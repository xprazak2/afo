#object false

extends "users/show"

if @user.errors.any?
  node :errors do |errors|
    errors.keys.each do |key|
      node(key) { errors[key] }
    end
  end
end
