require 'rails_helper'

describe User do
  
  let(:user) { FactoryGirl.create(:user) }
  
  describe "create" do
    it { FactoryGirl.build(:user).save.should == true }
    
    it "encrypts password" do
      user = FactoryGirl.create(:user, password: "foo")
      saved_user = User.first
      saved_user.password_digest.should_not == "foo"
      saved_user.password.should == nil
    end
  end
  
  describe "validation" do
    it { FactoryGirl.build(:user, email: nil).save.should == false }
    it { FactoryGirl.build(:user, password: nil).save.should == false }
  end
  
  describe "update" do
    it "encrypts password when password changes" do
      old_encrypted_password = user.password_digest
      user.password = "new pass"
      user.save
      user.reload.password_digest.should_not == old_encrypted_password
    end
    
    it "doesn't encrypt password when password doesn't change" do
      old_encrypted_password = user.password_digest
      user.email = "new@email.com"
      user.save
      user.reload.password_digest.should == old_encrypted_password
    end
  end

  describe "relations" do
    it "has websites" do
      user.websites = FactoryGirl.create_list(:website, 2)
      user.save

      user.websites.count.should == 2
      User.first.websites.count.should == 2
    end

    it "adds new websites" do
      website = user.websites.create(name: "foo", url: "http://foo.bar")
      user.save!

      user.websites.count.should == 1
      Website.count.should == 1
      User.first.websites.should == [website]
    end

    it "adds existing website" do
      website = FactoryGirl.create(:website)
      user.websites.push(website)

      user.websites.count.should == 1
      Website.count.should == 1
      User.first.websites.should == [website]
    end

    it "removes existing website" do
      website = user.websites.create(name: "foo", url: "http://foo.bar")
      user.save!
      user.websites.delete(website)

      user.websites.count.should == 0
      Website.count.should == 1
      User.first.websites.should == []
    end
  end

  describe "has_website?" do
    before(:each) do
      @website = user.websites.create(name: "foo", url: "http://foo.bar")
      user.save!
    end

    it { user.has_website?(website: @website).should == true }
    it { user.has_website?(website: FactoryGirl.create(:website, name: "foo1")).should == false }
  end
end