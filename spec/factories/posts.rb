FactoryGirl.define do
  factory :post do
    name "string"
    status "string"
    scrapping { FactoryGirl.create(:scrapping) }
    website { FactoryGirl.create(:website) }
  end
end