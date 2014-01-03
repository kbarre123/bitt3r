FactoryGirl.define do
  factory :user do
    name "Example User"
    email "user@example.org"
    password "foobar"
    password_confirmation "foobar"
  end
end