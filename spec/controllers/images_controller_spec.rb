require 'spec_helper'

describe ImagesController do
  render_views

  let(:website) { FactoryGirl.create(:website) }
  let(:to_sort_post) { FactoryGirl.create(:post, :status => Post::TO_SORT_STATUS, :website => website) }
  let(:to_sort_image) { FactoryGirl.create(:image, :status => Image::TO_SORT_STATUS, :website => website, :post => to_sort_post) }

  describe "GET index" do
    
    it "returns post with status to_sort" do
      sorted_post = FactoryGirl.create(:post, :status => Post::SORTED_STATUS, :website => website)
      
      get 'index', :website_id => website.id, :post_id => to_sort_post.id
      
      assigns(:post).should eq(to_sort_post)
    end

    context "to sort images" do
      it "returns latest post images" do
        to_sort_post2 = FactoryGirl.create(:post, :status => Post::TO_SORT_STATUS, :name => "post2", :website => website)
        
        image = FactoryGirl.create(:image, :post => to_sort_post2, :status => Image::TO_SORT_STATUS)

        get 'index', :website_id => website.id, :post_id => to_sort_post2.id, "status" => Image::TO_SORT_STATUS

        assigns(:images).all.entries.should eq([image])
      end
    end

    context "to keep images" do
      it "returns website images" do
        image = FactoryGirl.create(:image, :website => website, :status => Image::TO_KEEP_STATUS)
        image2 = FactoryGirl.create(:image, :post => to_sort_post, :status => Image::TO_KEEP_STATUS)

        get 'index', :website_id => website.id, "status" => Image::TO_KEEP_STATUS

        assigns(:images).all.entries.should eq([image])
      end

      it "sets post to next post" do
        next_post = FactoryGirl.create(:post, :status => Post::TO_SORT_STATUS, :website => website)

        get 'index', :website_id => website.id, "status" => Image::TO_KEEP_STATUS

        assigns(:post).should eq(next_post)
      end
    end

    context "to delete images" do
      it "returns website images" do
        image = FactoryGirl.create(:image, :website => website, :status => Image::TO_DELETE_STATUS)
        image2 = FactoryGirl.create(:image, :post => to_sort_post, :status => Image::TO_DELETE_STATUS)

        get 'index', :website_id => website.id, "status" => Image::TO_DELETE_STATUS

        assigns(:images).all.entries.should eq([image])
      end

      it "sets post to next post" do
        next_post = FactoryGirl.create(:post, :status => Post::TO_SORT_STATUS, :website => website)

        get 'index', :website_id => website.id, "status" => Image::TO_DELETE_STATUS

        assigns(:post).should eq(next_post)
      end
    end
  end

  describe "PUT update" do
    it "updates image status to keep status" do
      put 'update', :website_id => website.id, :post_id => to_sort_post.id, :id => to_sort_image.id, :format => :js

      to_sort_image.reload.status.should == Image::TO_KEEP_STATUS
    end 

    it "calls check status" do
      Post.any_instance.expects(:check_status!).once

      put 'update', :website_id => website.id, :post_id => to_sort_post.id, :id => to_sort_image.id, :format => :js
    end
  end

  describe "DELETE destroy" do
    it "updates image status to delete status" do
      delete 'destroy', :website_id => website.id, :post_id => to_sort_post.id, :id => to_sort_image.id, :format => :js

      to_sort_image.reload.status.should == Image::TO_DELETE_STATUS
    end

    it "calls check status" do
      Post.any_instance.expects(:check_status!).once

      delete 'destroy', :website_id => website.id, :post_id => to_sort_post.id, :id => to_sort_image.id, :format => :js
    end
  end 

  describe "DELETE destroy_all" do
    before :each do
      @image2 = FactoryGirl.create(:image, :status => Image::TO_SORT_STATUS, :post => to_sort_post, :website => website)
    end

    it "updates image status to delete status" do
      delete 'destroy_all', :website_id => website.id, :post_id => to_sort_post.id, "image" => {"ids" => [to_sort_image.id]}

      to_sort_image.reload.status.should == Image::TO_DELETE_STATUS
      @image2.reload.status.should == Image::TO_SORT_STATUS
    end

    it "calls check status of post" do
      Post.any_instance.expects(:check_status!).once

      delete 'destroy_all', :website_id => website.id, :post_id => to_sort_post.id, "image" => {"ids" => [to_sort_image.id]}
    end

    context "all images are sorted" do
      it "redirects to next post" do
        next_to_sort_post = FactoryGirl.create(:post, :status => Post::TO_SORT_STATUS, :website => website)

        delete 'destroy_all', :website_id => website.id, :post_id => to_sort_post.id, "image" => {"ids" => [to_sort_image.id, @image2.id]}

        response.should redirect_to website_post_images_url(assigns(:website), next_to_sort_post)
      end
    end

    context "not all images are sorted" do
      it "redirects to next post" do
        next_to_sort_post = FactoryGirl.create(:post, :status => Post::TO_SORT_STATUS, :website => website)

        delete 'destroy_all', :website_id => website.id, :post_id => to_sort_post.id, "image" => {"ids" => [to_sort_image.id]}

        response.should redirect_to website_post_images_url(assigns(:website), to_sort_post)
      end
    end
  end

  describe "PUT redownload" do
    it "redownloads image" do
      Image.any_instance.expects(:download).once

      put 'redownload', :website_id => website.id, :post_id => to_sort_post.id, :id => to_sort_image.id, :format => :js
    end
  end
end