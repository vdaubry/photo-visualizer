FactoryGirl.define do
  factory :scrapping do |f|
    f.date DateTime.now
    f.duration 1234
    f.website "string"
    f.image_count 1234
    f.success true
  end
end