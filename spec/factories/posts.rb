FactoryGirl.define do
  factory :post do
    sequence(:name) {|i| "string#{i}"}
    sequence(:url) {|i| "http://string#{i}.com" }
    website
  end
end