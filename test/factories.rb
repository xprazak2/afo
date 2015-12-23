FactoryGirl.define do
  factory :user, :class => Afo::User do
    name "admin"
    password "changeme"
  end

  factory :comic, :class => Afo::Comic do
    user nil
    sequence(:title) { |n| "title_#{n}" }
    sequence(:path) { |n| "/public/comic/#{n}" }
    file nil
  end

  factory :content, :class => Afo::Content do
    name "some_name"
    content "some_content"
  end
end