FactoryGirl.define do
  factory :image do
    src "http://url.com"
    href "http://url.com"
    scrapped_at DateTime.parse("20/10/2010")
    website
    post
  end
end