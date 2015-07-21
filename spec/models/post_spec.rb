require 'rails_helper'

describe Post do

  let(:post) { FactoryGirl.create(:post) }
  let(:website) { FactoryGirl.create(:website) }
  
  describe "create" do
    it { FactoryGirl.build(:post).save.should == true }
  end
  
  describe "validation" do
    it { FactoryGirl.build(:post, name: nil).save.should == false }
    it { FactoryGirl.build(:post, url: nil).save.should == false }
    it { FactoryGirl.build(:post, website: nil).save.should == false }

    it "has unique name for the same website" do
      FactoryGirl.build(:post, name: "foo", website: website).save.should == true
      FactoryGirl.build(:post, name: "foo", website: website).save.should == false
    end

    it "has not unique name for the different website" do
      FactoryGirl.build(:post, name: "foo", website: website).save.should == true
      FactoryGirl.build(:post, name: "foo", website: FactoryGirl.create(:website)).save.should == true
    end

    it "has unique url even for the different website" do
      FactoryGirl.build(:post, url: "http://foo.bar").save.should == true
      FactoryGirl.build(:post, url: "http://foo.bar").save.should == false
    end
  end

  describe "relations" do
    it "belongs to website" do
      website = FactoryGirl.create(:website)
      posts = FactoryGirl.create_list(:post, 2, website: website)

      posts.each {|p| p.website.should == website }
    end

    it "has images" do
      post = FactoryGirl.create(:post)
      post.images = FactoryGirl.create_list(:image, 2)
      post.save

      post.images.count.should == 2
      Post.first.images.count.should == 2
    end

    it "cascades deletes images" do
      post.images = FactoryGirl.create_list(:image, 2)
      post.save

      post.destroy
      Image.count.should == 0
    end
  end
end
