FactoryGirl.define do
  factory :user, :class => Afo::User do
    username "admin"
    password "changeme"
  end
end