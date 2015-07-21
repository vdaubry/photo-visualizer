class UserImageBuilder
  def initialize(user:, image:)
    @user = user
    @image = image
    @queue = Facades::Queue.new(queue_name: "image_download")
  end

  def build
    user_image = @user.user_images.create(image: @image)
    msg = {image: {
        src: @image.src,
        href: @image.href,
        id: @image.id
    }.to_json}
    @queue.send(msg: msg)
    user_image
  end
end