require 'spec_helper'

describe PostsController do
  render_views

  describe "DELETE destroy" do

    context "has next post" do
      it "redirects to next post" do
        stub_request(:get, "http://localhost:3002/websites/123/posts/456.json")
        .to_return(:body => '{"latest_post":"506144650ed4c08d84000001"}', 
                  :status => 200)

        delete 'destroy', :id => 456, :website_id => 123

        response.should redirect_to website_post_images_path(123, "506144650ed4c08d84000001")
      end
    end

    context "no more posts" do
      it "redirects to root_path" do
        stub_request(:get, "http://localhost:3002/websites/123/posts/456.json")
        .to_return(:body => '{"latest_post":null}', 
                  :status => 200)

        delete 'destroy', :id => 456, :website_id => 123

        response.should redirect_to root_path
      end
    end
  end

end