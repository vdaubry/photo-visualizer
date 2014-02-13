require 'spec_helper'

describe PostsController do
  render_views

  describe "DELETE destroy" do

    let(:website) { FactoryGirl.create(:website) }
    let(:post) { FactoryGirl.create(:post, :status => Post::TO_SORT_STATUS, :website => website) }

    context "has next post" do
      before(:each) do
        @next_post = FactoryGirl.create(:post, :status => Post::TO_SORT_STATUS, :website => website)
      end
      it "sets all remaining images to delete_status" do
        FactoryGirl.create_list(:image, 2, :post => post, :status => Image::TO_SORT_STATUS)
        FactoryGirl.create_list(:image, 2, :post => post, :status => Image::TO_KEEP_STATUS)

        delete 'destroy', :id => post.id, :website_id => website.id

        post.images.where(:status => Image::TO_SORT_STATUS).count.should == 0
        post.images.where(:status => Image::TO_DELETE_STATUS).count.should == 2
        post.images.where(:status => Image::TO_KEEP_STATUS).count.should == 2
      end

      it "sets post to sorted" do
        delete 'destroy', :id => post.id, :website_id => website.id

        post.reload.status.should == Post::SORTED_STATUS
      end

      it "redirects to next post" do
        delete 'destroy', :id => post.id, :website_id => website.id

        response.should redirect_to website_post_images_path(website, @next_post)
      end
    end

    context "no more posts" do
      it "redirects to root_path" do
        delete 'destroy', :id => post.id, :website_id => website.id

        response.should redirect_to root_path
      end
    end
  end

end