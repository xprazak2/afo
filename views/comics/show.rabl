object @comic

attributes :id, :title, :path, :created_at, :updated_at

child :user => :user do
  extends "users/show"
end
