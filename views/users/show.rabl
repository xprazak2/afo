object @user
attributes :id, :last_login

node(:name) { |u| u.to_initial }
