require 'spec_helper'

describe WebsitesController, :speed => :slow do
  render_views

  before(:all) { WebMock.allow_net_connect! }
  after(:all) { WebMock.disable_net_connect! }

  describe "GET index" do
    it "returns websites as json" do
      get 'index'

      assigns(:websites).count.should == 5
    end    
  end
end