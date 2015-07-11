require 'rails_helper'

describe WebsitesController do

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

      it "assigns all websites" do
        websites = FactoryGirl.create_list(:website, 2)
        get :index
        assigns(:websites).should == websites
      end
    end
  end

end