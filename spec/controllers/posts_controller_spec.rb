require 'spec_helper'

describe PostsController do
  render_views

  describe "DELETE destroy" do

    let(:website) { FactoryGirl.create(:website) }
    let(:post) { FactoryGirl.create(:post, :status => Post::TO_SORT_STATUS, :website => website) }


    it "sets all images to sorted" do
      images = FactoryGirl.create_list(:image, 2, :post => post, :status => Image::TO_SORT_STATUS)

      delete 'destroy', :id => post.id, :website_id => website.id

      post.images.where(:status => Image::TO_SORT_STATUS).count.should == 0
      post.images.where(:status => Image::TO_DELETE_STATUS).count.should == 2
    end

    it "sets post to sorted" do
      delete 'destroy', :id => post.id, :website_id => website.id

      post.reload.status.should == Post::SORTED_STATUS
    end
  end

end