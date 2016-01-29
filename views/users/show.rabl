object @user
attributes :id, :name, :last_login

node(:initial) { |u| u.to_initial }
