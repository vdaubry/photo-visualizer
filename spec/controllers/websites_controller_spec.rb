require 'spec_helper'

describe WebsitesController do
  render_views

  describe "GET index" do
    let(:websites_json) {'{"websites":[
                                      {"id":"506144650ed4c08d84000001","name":"some name","url":"some url","last_scrapping_date":"-","images_to_sort_count":0,"latest_post_id":null},
                                      {"id":"506144650ed4c08d84000001","name":"some name","url":"some url","last_scrapping_date":"-","images_to_sort_count":0,"latest_post_id":null}
                          ]}'}

    let(:zips_json) {'{"zipfiles": [
                          {"url": "https://photovisualizer-dev.s3.amazonaws.com/foo.zip?AWSAccessKeyId=foobar&Expires=1414081148&Signature=nWssW0ZxVG5EPsy4QgGuAk63ZP4%3D","key": "foo.zip"},
                          {"url": "https://photovisualizer-dev.s3.amazonaws.com/bar.zip?AWSAccessKeyId=foobar&Expires=1414081148&Signature=yNmfC4EZ%2BEzS3HK%2BnKn6lgNWdJk%3D","key": "bar.zip"}
                      ]}'}

    before(:each) do
      stub_request(:get, "http://localhost:3002/websites.json")
      .to_return(:headers => {"Content-Type" => 'application/json'},
                  :body => websites_json, 
                  :status => 200)

      stub_request(:get, "http://localhost:3002/zipfiles.json")
      .to_return(:headers => {"Content-Type" => 'application/json'},
                  :body => zips_json, 
                  :status => 200)
    end

    it "returns websites as json" do
      get 'index'

      website1 = assigns(:websites)[0]
      website1["name"].should == "some name"

      website1 = assigns(:websites)[1]
      website1["name"].should == "some name"
    end

    it "returns websites as json" do
      get 'index'

      zip1 = assigns(:zipfiles)[0]
      zip1["url"].should == "https://photovisualizer-dev.s3.amazonaws.com/foo.zip?AWSAccessKeyId=foobar&Expires=1414081148&Signature=nWssW0ZxVG5EPsy4QgGuAk63ZP4%3D"

      zip2 = assigns(:zipfiles)[1]
      zip2["url"].should == "https://photovisualizer-dev.s3.amazonaws.com/bar.zip?AWSAccessKeyId=foobar&Expires=1414081148&Signature=yNmfC4EZ%2BEzS3HK%2BnKn6lgNWdJk%3D"
    end
  end
end