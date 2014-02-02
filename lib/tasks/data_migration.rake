namespace :migration do

  desc "Migrate data"
  task :start  => :environment do
    Website.delete_all
  	website = Website.create(:name => "WBW", :url => "https://whatboyswant.com/")

  	Image.where(:website => nil).update_all(:website => website)

  	Scrapping.update_all( { $unset => { website: 1 } } )

  	Scrapping.each do |scrapping|
  		scrapping.website = website
  		scrapping.save
  	end
  end
end