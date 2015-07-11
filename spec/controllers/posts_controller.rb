require 'rails_helper'

describe PostsController do

  let(:user) { FactoryGirl.create(:user) }
  let(:post) { FactoryGirl.create(:post) }
  
  describe "GET show" do
    context "user logged out" do
      it "redirects to root_path nil" do
        get :show, id: post.to_param
        response.should redirect_to root_path
      end
    end

    context "user logged in" do 
      before(:each) do
        session[:user_id] = user.id
        @website = FactoryGirl.create(:website)
        @posts = FactoryGirl.create_list(:post, 2, website: @website)
        @post = @posts.first
      end

      it "assigns all posts" do
        get :show, id: @post.to_param
        assigns(:posts).should == @posts
      end

      it "assigns post" do
        get :show, id: @post.to_param
        assigns(:post).should == @post
      end

      it "assigns website" do
        get :show, id: @post.to_param
        assigns(:website).should == @website
      end
    end
  end

end