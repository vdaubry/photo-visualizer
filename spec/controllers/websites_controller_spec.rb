require 'spec_helper'

describe WebsitesController do
  render_views

  describe "GET index" do

    it "returns websites as json" do
      stub_request(:get, "http://localhost:3002/websites.json")
      .to_return(:body => '[{"id":123,"name":"some name","url":"some url","last_scrapping_date":"-","images_to_sort_count":0,"latest_post_id":null},{"id":123,"name":"some name","url":"some url","last_scrapping_date":"-","images_to_sort_count":0,"latest_post_id":null}]', 
                  :status => 200)

      get 'index'

      website1 = assigns(:websites)[0]
      website1["name"].should == "some name"

      website1 = assigns(:websites)[1]
      website1["name"].should == "some name"
    end
  end
end