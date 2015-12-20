object @comic

attributes :id, :title, :created_at, :updated_at, :file

child :user => :user do
  extends "users/show"
end
