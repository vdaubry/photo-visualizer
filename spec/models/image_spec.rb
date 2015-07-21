require 'rails_helper'

describe Image do

  let(:image) { FactoryGirl.create(:image) }
  
  describe "create" do
    it { FactoryGirl.build(:image).save.should == true }
  end
  
  describe "validation" do
    it { FactoryGirl.build(:image, src: nil).save.should == false }
    it { FactoryGirl.build(:image, href: nil).save.should == true }
    it { FactoryGirl.build(:image, post: nil).save.should == false }
    it { FactoryGirl.build(:image, website: nil).save.should == false }

    it "validates uniqueness of images" do
      FactoryGirl.build(:image, src: "http://foo.bar/1.jpg").save.should == true
      FactoryGirl.build(:image, src: "http://foo.bar/1.jpg").save.should == false
    end
  end

  describe "relations" do
    it "belongs to website" do
      website = FactoryGirl.create(:website)
      images = FactoryGirl.create_list(:image, 2, website: website)

      images.each {|i| i.website.should == website }
      Website.first.images.should == images
    end

    it "belongs to post" do
      post = FactoryGirl.create(:post)
      images = FactoryGirl.create_list(:image, 2, post: post)

      images.each {|i| i.post.should == post }
      Post.first.images.should == images
    end
  end
end
