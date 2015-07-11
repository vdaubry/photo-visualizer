FactoryGirl.define do
  factory :website do
    sequence(:name) {|i| "string#{i}"}
    sequence(:url) {|i| "http://string#{i}.com" }
  end
end