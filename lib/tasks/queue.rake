task "listen" => :environment do
  Facades::Queue.new.poll do |msg|
    parser = ImageMessageParser.new(msg)
    # builder = ImageBuilder.new( website_name: parser.website_name
    #                             website_url: parser.website_url, 
    #                             post_name: parser.post_name,
    #                             post_url: parser.post_url,
    #                             image_thumb_url: parser.image_thumb_url,
    #                             image_target_url: parser.image_target_url,
    #                             image_scrapped_at: parser.image_scrapped_at)
    builder = ImageBuilder.new(image_message_parser: parser)
    builder.create
  end
end
