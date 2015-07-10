require 'rails_helper'

describe User do
  
  let(:user) { FactoryGirl.create(:user) }
  
  describe "create" do
    it { FactoryGirl.build(:user).save!.should == true }
    
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
end