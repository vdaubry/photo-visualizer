FactoryGirl.define do
  factory :user_post do
    user
    post
    last_image_scrapped_at DateTime.parse("20/10/2010")
  end
end