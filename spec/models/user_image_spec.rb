require "rails_helper"

describe UserImage do
  describe "create" do
    it { FactoryGirl.build(:user_image).save.should == true }

    describe "validation" do
      it { FactoryGirl.build(:user_image, user: nil).save.should == false }
      it { FactoryGirl.build(:user_image, image: nil).save.should == false }

      it "validates uniquess of image per user" do
        user = FactoryGirl.create(:user)
        image = FactoryGirl.create(:image)
        FactoryGirl.build(:user_image, user: user, image: image).save.should == true
        FactoryGirl.build(:user_image, user: user, image: image).save.should == false
      end
    end
  end
end