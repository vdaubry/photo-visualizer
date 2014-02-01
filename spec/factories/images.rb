FactoryGirl.define do
  factory :image do |f|
    f.sequence(:key ) { |n| "key_#{n}" }
    f.sequence(:hash ) { |n| "hash_#{n}" }
    f.statut "string"
    f.file_size 1234
    f.width 1234
    f.height 1234
    f.source_url "string"
  end
end