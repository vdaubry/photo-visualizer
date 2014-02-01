require 'spec_helper'

describe Scrapping do

	before :each do
	end

	describe "save" do
		context "valid" do 
			it { FactoryGirl.build(:scrapping).save.should == true }
		end

		context "duplicates url and date" do 
			it { 
				date = 1.day.ago
				FactoryGirl.create(:scrapping, :date => date, :website => "foo", :success => true)
				FactoryGirl.build(:scrapping, :date => date, :website => "foo", :success => false).save.should == false 
			}
		end

	end
end
