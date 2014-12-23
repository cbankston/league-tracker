FactoryGirl.define do
  factory :user do

    sequence(:email) do |n|
      "foo#{n}@bar.com"
    end

    password 'password'
  end
end
