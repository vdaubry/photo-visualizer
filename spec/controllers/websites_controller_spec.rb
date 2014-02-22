require 'spec_helper'

describe WebsitesController do
  render_views

  describe "GET index" do

    let(:websites_json) {'{"websites":[
                                      {"id":"506144650ed4c08d84000001","name":"some name","url":"some url","last_scrapping_date":"-","images_to_sort_count":0,"latest_post_id":null},
                                      {"id":"506144650ed4c08d84000001","name":"some name","url":"some url","last_scrapping_date":"-","images_to_sort_count":0,"latest_post_id":null}
                                      ]}'}

    it "returns websites as json" do
      stub_request(:get, "http://localhost:3002/websites.json")
      .to_return(:body => websites_json, 
                  :status => 200)

      get 'index'

      website1 = assigns(:websites)[0]
      website1["name"].should == "some name"

      website1 = assigns(:websites)[1]
      website1["name"].should == "some name"
    end
  end
end