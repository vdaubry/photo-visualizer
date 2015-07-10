FactoryGirl.define do
  factory :image do
    thumb_url "http://url.com"
    target_url "http://url.com"
    scrapped_at DateTime.parse("20/10/2010")
    website
    post
  end
end