FactoryGirl.define do 
  factory :user do 
    email   "chris@gmail.com"
    password "12345678"
    password_confirmation "12345678"
  end
end