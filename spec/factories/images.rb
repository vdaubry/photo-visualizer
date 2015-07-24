FactoryGirl.define do
  factory :image do
    sequence(:src) {|i| "http://url.com#{i}"}
    href "http://url.com"
    scrapped_at DateTime.parse("20/10/2010")
    website
    post
  end
end