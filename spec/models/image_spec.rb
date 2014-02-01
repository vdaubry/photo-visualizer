require 'spec_helper'

describe Image do

	before :each do
	end

	describe "save" do
		it "saves valid image" do
			FactoryGirl.build(:image).save.should == true
		end
	end
end
