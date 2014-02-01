# encoding: utf-8

namespace :scrapping do

    desc "Scrap websites in websites.yml"
    task :reset  => :environment do
      Image.delete_all
      Scrapping.delete_all
      FileUtils.rm_rf('app/assets/images/to_sort')
      FileUtils.mkdir_p 'app/assets/images/to_sort/thumbnails/300'
      FileUtils.cp 'lib/calinours_mini.jpg', 'app/assets/images/to_sort/thumbnails/300/calinours.jpg'
      FileUtils.cp 'lib/calinours.jpg', 'app/assets/images/to_sort/calinours.jpg'
    end

  desc "Scrap websites in websites.yml"
  task :website1  => :environment do
  	require 'open-uri'
    require 'digest/md5'

  	url = YAML.load_file('config/websites.yml')["website1"]["url"]

  	last_scrapping = Scrapping.where(:success => true, :website => url).asc(:date).limit(1).first
  	previous_month = 1.month.ago
  	if last_scrapping
  		previous_month = (last_scrapping.date - 1.month)
  	end

  	scrapping = Scrapping.find_or_initialize_by(:date => previous_month, :website => url, :success => false)
  	start_time = DateTime.now
	    
    user = YAML.load_file('config/websites.yml')["website1"]["username"]
    password = YAML.load_file('config/websites.yml')["website1"]["password"]
    top_link = YAML.load_file('config/websites.yml')["website1"]["top_link"]

    pp "Start scrapping #{url} for month : #{previous_month.strftime("%Y/%B")}"
    home_page = Mechanize.new.get(url)

    pp "Sign in user : #{user}"
    sign_in_page = home_page.links.find { |l| l.text == 'Log-in' }.click
    page = sign_in_page.form_with(:name => nil) do |form|
    	form.fields.second.value = user
    	form.fields.third.value = password
	end.submit
  	
  	top_page = page.link_with(:text => top_link).click

  	images_saved=0
  	(1..14).each do |category_number|
  		images_saved += scrap_category(top_page, YAML.load_file('config/websites.yml')["website1"]["category#{category_number}"], previous_month) 
  	end

  	scrapping.update_attributes(
  	  success: true,
  	  duration: DateTime.now-start_time,
  	  image_count: images_saved
  	)

  end


  def scrap_category(page, category, previous_month)
  	pp "Scrap category : #{category} - #{previous_month.strftime("%Y/%B")}"
   	page = page.link_with(:text => category).click
   	page = page.link_with(:text => previous_month.strftime("%Y")).click
   	page = page.link_with(:text => previous_month.strftime("%B")).click

   	link_reg_exp = YAML.load_file('config/websites.yml')["website1"]["link_reg_exp"]
   	links = page.links_with(:href => %r{#{link_reg_exp}})[0..1]
   	pp "Found #{links.count} links" 
   	images_saved = 0
   	links.each do |link|
   		page = link.click
   		page_image = page.image_with(:src => %r{/norm/})
   		url = page_image.url.to_s

   		filename =  DateTime.now.to_i.to_s + "_" + File.basename(URI.parse(url).path)
      FileUtils.mkdir_p 'app/assets/images/to_sort/thumbnails/300'

   		if Image.where(:source_url => url).first.nil?
   			pp "Save #{filename}"
	   		file_path = "app/assets/images/to_sort/#{filename}"
	   		open(file_path, 'wb') do |file|
			   file << open(url).read
        end
        
        image = MiniMagick::Image.open(file_path) 
        image.resize "300x300"
        image.write  "app/assets/images/to_sort/thumbnails/300/#{filename}"

        image_file = File.read(file_path)

        Image.create(:key => filename, 
          :image_hash => Digest::MD5.hexdigest(image_file),
          :width => FastImage.size(file_path)[0], 
          :height => FastImage.size(file_path)[1],
          :file_size => image_file.size,
          :source_url => url, 
          :status => Image::TO_SORT_STATUS)
        images_saved+=1
        sleep(1)
			end
   	end
   	images_saved
  end

end
