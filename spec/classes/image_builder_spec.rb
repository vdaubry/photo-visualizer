require "rails_helper"

describe "ImageBuilder" do

  let(:msg) { {"website": {
                "name": "web_foo",
                "url": "http://website.com"
                },
               "post": {
                "name": "post_foo",
                "url": "http://website.com/posts/foo"
                },
               "image": {
                "thumb_url": "http://images.com/thumbs/foo.jpg",
                "target_url": "http://images.com/foo.jpg",
                "scrapped_at": Time.now.to_s
                }}.to_json }
  let(:parser) { ImageMessageParser.new(msg) }

  describe "parse" do
    it "creates a new image" do
      expect {
        ImageBuilder.new(image_message_parser: parser).create
      }.to change{Image.count}.by(1)
    end


    context "new website" do
      it "creates the website" do
        expect {
          ImageBuilder.new(image_message_parser: parser).create
        }.to change {Website.count}.by(1)
      end

      it "fills website" do
        ImageBuilder.new(image_message_parser: parser).create
        website = Website.last
        website.name.should == "web_foo"
        website.url.should == "http://website.com"
      end

      it "assigns the image to the new website" do
        ImageBuilder.new(image_message_parser: parser).create
        Image.last.website.should == Website.last
      end
    end

    context "existing website" do
      before(:each) do
        @website = FactoryGirl.create(:website, url: "http://website.com")
      end

      it "doesn't create any website" do
        expect {
          ImageBuilder.new(image_message_parser: parser).create
        }.to change {Website.count}.by(0)
      end

      it "assigns image to existing website" do
        ImageBuilder.new(image_message_parser: parser).create
        Image.last.website.should == @website
      end
    end

    context "new post" do
      it "creates the post" do
        expect {
          ImageBuilder.new(image_message_parser: parser).create
        }.to change {Post.count}.by(1)
      end

      it "fills website" do
        ImageBuilder.new(image_message_parser: parser).create
        post = Post.last
        post.name.should == "post_foo"
        post.url.should == "http://website.com/posts/foo"
      end

      it "assigns the image to the new website" do
        ImageBuilder.new(image_message_parser: parser).create
        Image.last.post.should == Post.last
      end
    end

    context "existing post" do
      before(:each) do
        @post = FactoryGirl.create(:post, url: "http://website.com/posts/foo")
      end

      it "doesn't create any post" do
        expect {
          ImageBuilder.new(image_message_parser: parser).create
        }.to change {Post.count}.by(0)
      end

      it "assigns image to existing post" do
        ImageBuilder.new(image_message_parser: parser).create
        Image.last.post.should == @post
      end
    end
  end
end