User.destroy_all
user = User.create(email: "vdaubry@gmail.com", password: "azerty")

Website.destroy_all
5.times do |i|
  user.websites.create(name: "foo #{i}", url: "http://www.foo#{i}.com")
  user.save
end

  