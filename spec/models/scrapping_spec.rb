require 'spec_helper'

describe Scrapping do

	before :each do
	end

	describe "save" do
		context "valid" do 
			it { FactoryGirl.build(:scrapping).save.should == true }
			it { 
				date = 1.day.ago
				FactoryGirl.create(:scrapping, :date => date, :website => FactoryGirl.create(:website), :success => true)
				FactoryGirl.build(:scrapping, :date => date, :website => FactoryGirl.create(:website), :success => false).save.should == true
			}

			it {
				scrapping = FactoryGirl.create(:scrapping)
				FactoryGirl.create_list(:image, 2, :scrapping => scrapping)
				scrapping.images.count == 2
			}
		end

		context "duplicates url and date" do 
			it { 
				date = 1.day.ago
				website = FactoryGirl.create(:website)
				FactoryGirl.create(:scrapping, :date => date, :website => website, :success => true)
				FactoryGirl.build(:scrapping, :date => date, :website => website, :success => false).save.should == false 
			}
		end

	end
end
