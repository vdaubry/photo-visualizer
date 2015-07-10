require 'rails_helper'

describe ApplicationController do
  
  let(:user) { FactoryGirl.create(:user) }
  
  describe "current_user" do
    context "user logged in" do
      before(:each) do
        session[:user_id] = user.id
      end

      it "returns user" do
        controller.current_user.should == user
      end
    end

    context "user logged out" do
      it "returns nil" do
        controller.current_user.should == nil
      end
    end
  end

end