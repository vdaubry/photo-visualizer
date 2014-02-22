require 'spec_helper'

describe ImagesController do
  render_views

  let(:website) { FactoryGirl.create(:website) }
  let(:to_sort_post) { FactoryGirl.create(:post, :status => Post::TO_SORT_STATUS, :website => website) }
  let(:to_sort_image) { FactoryGirl.create(:image, :status => Image::TO_SORT_STATUS, :website => website, :post => to_sort_post) }

  describe "GET index" do    
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