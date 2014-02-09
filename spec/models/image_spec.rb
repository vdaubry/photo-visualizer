require 'spec_helper'

describe Image do

	describe "save" do
		context "valid" do
			it { FactoryGirl.build(:image).save.should == true }
		end
		
		context "null values" do
			it { FactoryGirl.build(:image, :key => nil).save.should == false }
			it { FactoryGirl.build(:image, :image_hash => nil).save.should == false }
			it { FactoryGirl.build(:image, :status => nil).save.should == false }
			it { FactoryGirl.build(:image, :file_size => nil).save.should == false }
			it { FactoryGirl.build(:image, :width => nil).save.should == false }
			it { FactoryGirl.build(:image, :height => nil).save.should == false }
			it { FactoryGirl.build(:image, :source_url => nil).save.should == false }
			it { FactoryGirl.build(:image, :post => nil).save.should == true }
			it { FactoryGirl.build(:image, :website => nil).save.should == false }
		end

		context "invalid status" do
			it { FactoryGirl.build(:image, :status => "foo").save.should == false }
		end
	end

	describe "build info" do
		let(:website) { FactoryGirl.create(:website) }
		let(:post) { FactoryGirl.create(:post) }

		it "create a new image with parameters" do
			fake_date = DateTime.parse("01/01/2014")
			DateTime.stubs(:now).returns fake_date
			url = "http://foo.bar"
			
			img = Image.new.build_info(url, website, post)

			img.source_url.should == url
			img.website.should == website
			img.key.should == fake_date.to_i.to_s + "_" + File.basename(URI.parse(url).path)
			img.status.should == Image::TO_SORT_STATUS
			img.post.should == post
		end

		it "format special characters" do
			fake_date = DateTime.parse("01/01/2014")
			DateTime.stubs(:now).returns fake_date
			url = "http://foo.bar/abc-jhvg-emil123.jpg"

			img = Image.new.build_info(url, website, post)

			img.key.should == fake_date.to_i.to_s + "_" + "abc_jhvg_emil123.jpg"
		end
	end

	describe "download" do
		it "saves file" do
			image = FactoryGirl.create(:image, :key => "calinours.jpg")
			Image.stubs(:image_path).returns("lib")
			Image.stubs(:thumbnail_path).returns("spec/ressources")
			image.stub_chain(:open, :read) { File.open("ressources/calinours.jpg").read }

			image.download

			image.image_hash.should == "a1e4b773a5cd2941a4a442b7309c8ced"
			image.file_size.should == 197890
			image.width.should == 1200
			image.height.should == 780
		end
	end
end
