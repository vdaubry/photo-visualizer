require 'rails_helper'

describe Website do
  
  let(:website) { FactoryGirl.create(:website) }
  
  describe "create" do
    it { FactoryGirl.build(:website).save.should == true }
  end
  
  describe "validation" do
    it { FactoryGirl.build(:website, name: nil).save.should == false }
    it { FactoryGirl.build(:website, url: nil).save.should == false }
  end

  describe "relations" do
    it "has posts" do
      website = FactoryGirl.create(:website)
      website.posts = FactoryGirl.create_list(:post, 2)
      website.save

      website.posts.count.should == 2
      Website.first.posts.count.should == 2
    end

    it "has images" do
      website = FactoryGirl.create(:website)
      website.posts = FactoryGirl.create_list(:image, 2)
      website.save

      website.images.count.should == 2
      Website.first.images.count.should == 2
    end
  end
end