require "rails_helper"

describe UserPost do
  describe "create" do
    it { FactoryGirl.build(:user_post).save.should == true }

    describe "validation" do
      it { FactoryGirl.build(:user_post, user: nil).save.should == false }
      it { FactoryGirl.build(:user_post, post: nil).save.should == false }
      it { FactoryGirl.build(:user_post, last_image_scrapped_at: nil).save.should == false }

      it "validates uniquess of post per user" do
        user = FactoryGirl.create(:user)
        post = FactoryGirl.create(:post)
        FactoryGirl.build(:user_post, user: user, post: post).save.should == true
        FactoryGirl.build(:user_post, user: user, post: post).save.should == false
      end
    end
  end
end