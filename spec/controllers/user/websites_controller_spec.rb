require 'rails_helper'

describe User::WebsitesController do

  let(:user) { FactoryGirl.create(:user) }
  let(:website) { FactoryGirl.create(:website) }
  
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

      it "assigns user websites" do
        user.websites = FactoryGirl.create_list(:website, 2)
        user.save
        get :index
        assigns(:websites).should == user.websites
      end

      it "returns empty websites if user has no websites" do
        get :index
        assigns(:websites).should == []
      end
    end
  end

  describe "PUT update" do
    context "user logged out" do
      it "redirects to root_path nil" do
        put :update, id: website.to_param
        response.should redirect_to root_path
      end
    end

    context "user logged in" do 
      before(:each) do
        session[:user_id] = user.id
      end

      it "adds websites" do
        put :update, id: website.to_param
        user.reload.websites.should == [website]
      end

      it "redirects to user websites" do
        put :update, id: website.to_param
        response.should redirect_to websites_path
      end
    end
  end

  describe "DELETE destroy" do
    context "user logged out" do
      it "redirects to root_path nil" do
        delete :destroy, id: website.to_param
        response.should redirect_to root_path
      end
    end

    context "user logged in" do 
      before(:each) do
        session[:user_id] = user.id
      end

      it "removes websites" do
        user.websites = [website]
        user.save

        delete :destroy, id: website.to_param

        user.reload.websites.should == []
      end

      it "redirects to user websites" do
        delete :destroy, id: website.to_param
        response.should redirect_to websites_path
      end
    end
  end
end