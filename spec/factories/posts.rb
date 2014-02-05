FactoryGirl.define do
  factory :post do
    name "string"
    status Post::TO_SORT_STATUS
    scrapping { FactoryGirl.create(:scrapping) }
    website { FactoryGirl.create(:website) }
  end
end