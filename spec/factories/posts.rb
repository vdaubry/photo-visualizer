FactoryGirl.define do
  factory :post do
    sequence(:name) { |n| "name_#{n}" }
    status Post::TO_SORT_STATUS
    scrapping { FactoryGirl.create(:scrapping) }
    website { FactoryGirl.create(:website) }
  end
end