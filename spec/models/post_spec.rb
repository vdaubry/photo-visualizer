require 'rails_helper'

describe Post do

  let(:post) { FactoryGirl.create(:post) }
  
  describe "create" do
    it { FactoryGirl.build(:post).save.should == true }
  end
  
  describe "validation" do
    it { FactoryGirl.build(:post, name: nil).save.should == false }
    it { FactoryGirl.build(:post, url: nil).save.should == false }
    it { FactoryGirl.build(:post, website: nil).save.should == false }
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
  end
end
