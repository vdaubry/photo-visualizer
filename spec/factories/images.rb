FactoryGirl.define do
  factory :image do |f|
    f.sequence(:key ) { |n| "key_#{n}" }
    f.sequence(:image_hash ) { |n| "hash_#{n}" }
    f.status Image::TO_KEEP_STATUS
    f.file_size 1234
    f.width 1234
    f.height 1234
    f.source_url "string"
  end
end