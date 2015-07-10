task "listen" => :environment do
  Facades::Queue.new.poll do |msg|
    ImageBuilder.new(msg: JSON.parse(msg)).create
  end
end