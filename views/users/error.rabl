extends "users/show"

if @user.errors.any?
  node :errors do
    @user.errors.keys.map { |k| { k.to_s => @user.errors[k] } }
  end
end
