namespace :migration do

  desc "Migrate data"
  task :start  => :environment do
    Website.each do |website|
      website.scrappings.each do |scrapping|
        post = scrapping.posts.find_or_create_by(:name => "undefined", :status => Post::SORTED_STATUS)
        post.update_attributes(:website => website)
      end
    end     
  end
end