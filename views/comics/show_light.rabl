object @comic

attributes :id, :title

node(:created_at) { |c| c.pretty_created_at }
node(:updated_at) { |c| c.pretty_updated_at }

child :user => :user do
  extends "users/show"
end