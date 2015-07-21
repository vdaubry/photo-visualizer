def create_user
  User.destroy_all
  User.create!(email: "vdaubry@gmail.com", password: "azerty")  
end

def create_websites
  Website.destroy_all
  user = User.first
  5.times do |i|
    user.websites.create!(name: "website foo #{i}", url: "http://www.foo#{i}.com")
    user.save
  end
end

def create_posts
  Post.destroy_all
  Website.each do |website|
    25.times do |i|
      Post.create!(name: "post foo #{i}", url: "http://www.foo/#{website.id}/#{i}.com", website_id: website.id)
    end
  end
end

def create_images
  Image.destroy_all
  Post.each_with_index do |post, i|
    75.times do |i|
      Image.create!(src: "http://placehold.it/300x300", href: "http://www.thumb/#{post.id}/foo#{i}.com", scrapped_at: (Time.now - i), post_id: post.id, website_id: post.website.id)
    end
  end
end


puts "Creating user"
create_user
puts "Creating websites"
create_websites
puts "Creating posts"
create_posts
puts "Creating images"
create_images
