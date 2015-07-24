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
        assigns(:presenter).posts.should == @posts
      end

      it "assigns post" do
        get :show, id: @post.to_param
        assigns(:post).should == @post
      end

      it "assigns website" do
        get :show, id: @post.to_param
        assigns(:website).should == @website
      end

      it "assigns images" do
        @images = FactoryGirl.create_list(:image, 2, post: @post)
        get :show, id: @post.to_param
        assigns(:presenter).images.all.should == @images
      end

      it "assigns favorites" do
        image = FactoryGirl.create(:image, post: @post)
        favorite = FactoryGirl.create(:user_image, user: user, image: image)
        get :show, id: @post.to_param
        assigns(:presenter).favorites.should == [favorite.id]
      end

      it "saves last image seen" do
        @images = FactoryGirl.create_list(:image, 2, post: @post)
        get :show, id: @post.to_param
        user.user_posts.first.last_image_scrapped_at.should == @images.first.scrapped_at
      end

      context "first time user sees post" do
        it "sets current page to 0" do
          @images = FactoryGirl.create_list(:image, 2, post: @post)
          get :show, id: @post.to_param
          assigns(:presenter).current_page.should == 0
        end
      end

      describe "current page" do
        before(:each) do
          UserPostDecorator.any_instance.stubs(:per).returns(2)
          FactoryGirl.create_list(:image, 2, post: @post, scrapped_at: Date.parse("15/01/2010"))
          FactoryGirl.create_list(:image, 2, post: @post, scrapped_at: Date.parse("15/02/2010"))
          FactoryGirl.create_list(:image, 2, post: @post, scrapped_at: Date.parse("15/03/2010"))
        end

        context "User has already seen page 1" do
          it "sets current page to 1" do
            FactoryGirl.create(:user_post, post: @post, user: user, last_image_scrapped_at: Date.parse("15/02/2010"))
            get :show, id: @post.to_param
            assigns(:presenter).current_page.should == 1
          end
        end

        context "User has already seen page 2" do
          it "sets current page to 1" do
            FactoryGirl.create(:user_post, post: @post, user: user, last_image_scrapped_at: Date.parse("15/03/2010"))
            get :show, id: @post.to_param
            assigns(:presenter).current_page.should == 2
          end
        end
      end
    end
  end

end