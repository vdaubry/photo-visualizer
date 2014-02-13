require 'spec_helper'

describe Post do

	describe "save" do
		context "valid" do
			it { FactoryGirl.build(:post).save.should == true }

			it { 
				images = FactoryGirl.create_list(:image, 2)
				post = FactoryGirl.create(:post)
				post.images = images
				post.images.count.should == 2
			}
		end

		context "invalid status" do
			it { FactoryGirl.build(:post, :status => "foo").save.should == false }
		end
	end

	describe "scopes" do
		before(:each) do
			@post_to_sort = FactoryGirl.create(:post, :status => Post::TO_SORT_STATUS)
			@sorted_post = FactoryGirl.create(:post, :status => Post::SORTED_STATUS)
		end

		it {Post.to_sort.should == [@post_to_sort]}
		it {Post.sorted.should == [@sorted_post]}
	end
end
