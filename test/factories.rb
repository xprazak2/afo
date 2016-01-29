FactoryGirl.define do
  factory :user, :class => Afo::User do
    sequence(:name) { |n| "admin#{n}" }
    password "changeme"
  end

  factory :comic, :class => Afo::Comic do
    user nil
    sequence(:title) { |n| "title_#{n}" }
    sequence(:path) { |n| "/public/comic/#{n}" }
    file nil
    created_at Time.utc(2015, 12, 24, 17, 49)
    updated_at Time.utc(2015, 12, 24, 17, 49)
  end

  factory :content, :class => Afo::Content do
    sequence(:title) { |n| "test_name_#{n}" }
    content "some_content"
  end
end