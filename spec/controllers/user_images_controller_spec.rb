require "rails_helper"

describe UserImagesController do

  let(:user) { FactoryGirl.create(:user) }

  describe "GET index" do
    context "user logged out" do
      it "redirects to root_path nil" do
        get :index
        response.should redirect_to root_path
      end
    end

    context "user logged in" do
      before(:each) do
        session[:user_id] = user.id
      end

      it "assigns user images" do
        user_images = FactoryGirl.create_list(:user_image, 2, user: user)
        get :index
        assigns(:images).should == user_images
      end

      it "assigns all images as favorites" do
        user_images = FactoryGirl.create_list(:user_image, 2, user: user)
        get :index
        assigns(:favorites).should == user_images.map(&:id)
      end
    end
  end

  describe "POST create" do
    context "user logged out" do
      it "redirects to root_path nil" do
        post :create, id: 1
        response.should redirect_to root_path
      end
    end

    context "user logged in" do
      before(:each) do
        session[:user_id] = user.id
      end

      it "adds an image to user favorites" do
        image = FactoryGirl.create(:image)
        post :create, id: image.to_param
        user.user_images.count.should == 1
        user.user_images.first.image.should == image
      end
    end
  end
end