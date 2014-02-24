require 'spec_helper'

describe ImagesController do
  render_views

  let(:images_json) {'{"images":[{"id":"530ba4234d61630836020000","key":"1393271843_1.jpg"},
                      {"id":"530ba4254d61630836030000","key":"1393271845_2.jpg"}],
                      "meta":{"to_sort_count":995,"to_keep_count":0,"to_delete_count":0}}'}

  describe "GET index" do  
    before(:each) do
      stub_request(:get, "http://localhost:3002/websites/123/posts/456/images.json")
      .to_return(:body => images_json, 
                  :status => 200)
    end  

    it "should return meta" do
      get 'index', :website_id => "123", :post_id => "456"

      assigns(:to_sort_count).should == 995
      assigns(:to_keep_count).should == 0
      assigns(:to_delete_count).should == 0
    end

    it "sets images" do
      get 'index', :website_id => "123", :post_id => "456"

      assigns(:images).should == [{"id" => "530ba4234d61630836020000","key" => "1393271843_1.jpg"},{"id" => "530ba4254d61630836030000","key" => "1393271845_2.jpg"}]
    end

    it "sets post_id and website_id" do
      get 'index', :website_id => "123", :post_id => "456"

      assigns(:website_id).should == "123"
      assigns(:post_id).should == "456"
    end
  end

  describe "PUT update" do
  end

  describe "DELETE destroy" do
  end 

  describe "DELETE destroy_all" do
  end

  describe "PUT redownload" do
  end
end