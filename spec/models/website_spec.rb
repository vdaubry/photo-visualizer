require 'rails_helper'

describe Website do
  
  let(:website) { FactoryGirl.create(:website) }
  
  describe "create" do
    it { FactoryGirl.build(:website).save.should == true }
  end
  
  describe "validation" do
    it { FactoryGirl.build(:website, name: nil).save.should == false }
    it { FactoryGirl.build(:website, url: nil).save.should == false }

    it "has unique name" do
      FactoryGirl.build(:website, name: "foo").save.should == true
      FactoryGirl.build(:website, name: "foo").save.should == false
    end

    it "has unique url" do
      FactoryGirl.build(:website, url: "http://foo.bar").save.should == true
      FactoryGirl.build(:website, url: "http://foo.bar").save.should == false
    end
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

  describe "latest_post" do
    it "returns lastest post" do
      post1 = FactoryGirl.create(:post, created_at: Date.yesterday)
      post2 = FactoryGirl.create(:post, created_at: Date.today)
      website.posts.push(post2)
      website.posts.push(post1)

      website.latest_post.should == post2
    end
  end
end