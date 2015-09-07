FactoryGirl.define do
  factory :user, :class => Afo::User do
    username "admin"
    password "changeme"
  end

  factory :comic, :class => Afo::Comic do
    user
    sequence(:title) { |n| "title-#{n}" }
    sequence(:path) { |n| "/public/comic/#{n}" }
  end
end