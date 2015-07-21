task "listen" => :environment do
  Facades::Queue.new(queue_name: "image_queue").poll do |msg|
    Rails.logger.debug "Found message : #{msg }"
    parser = ImageMessageParser.new(msg)
    builder = ImageBuilder.new(image_message_parser: parser)
    builder.create
  end
end
