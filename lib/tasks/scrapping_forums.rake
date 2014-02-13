# encoding: utf-8

namespace :forums do

  Str = Struct.new :url


#########################################################################################################
#
# Forums1
#
#########################################################################################################

  def allowed_formats
    %w(.jpg .jpeg .png .jpg~original)
  end

  desc "Scrap forum1 in forums.yml"
  task :forum1  => :environment do
  	require 'open-uri'
    require 'digest/md5'

  	url = YAML.load_file('config/forums.yml')["forum1"]["url"]
    website = Website.where(:url => url).first

  	last_scrapping = Scrapping.where(:success => true, :website => website).asc(:date).limit(1).first
    previous_scrapping_date = last_scrapping.nil? ? 1.month.ago.beginning_of_month : last_scrapping.date

    new_scrapping = website.scrappings.create(:date => DateTime.now)
    start_time = DateTime.now

    user = YAML.load_file('config/forums.yml')["forum1"]["username"]
    password = YAML.load_file('config/forums.yml')["forum1"]["password"]

    pp "Sign in user : #{user}"
    home_page = Mechanize.new.get(url)

    sign_in_page = home_page.links.find { |l| l.text == 'Log-in' }.click
    forums_page = sign_in_page.form_with(:name => nil) do |form|
      form.fields.second.value = user
      form.fields.third.value = password
    end.submit    

    pp "Start scrapping #{url} new images since : #{previous_scrapping_date}"

    (1..2).each do |category_number|
      category_name = YAML.load_file('config/forums.yml')["forum1"]["category#{category_number}"]
      forum_page = forums_page.link_with(:text => category_name).click
      scrap_forum(forum_page, website, new_scrapping, previous_scrapping_date)
    end

    images_saved = scrapping.posts.inject(0) {|result, post| result + post.images.count}

  	scrapping.update_attributes(
  	  success: true,
  	  duration: DateTime.now-start_time,
  	  image_count: images_saved
  	)
  end

  def scrap_forum(forum_page, website, scrapping, previous_scrapping_date)
    doc = forum_page.parser
    links = doc.xpath('//tr[@class=""]//td[@class="title"]//a').reject {|i| i[:href].include?("page:")}.map { |i| i[:href]}
    links.each do |link|
      post_page = forum_page.link_with(:href => link).click
      #scrap_post_direct_images(post_page, website, scrapping, previous_scrapping_date)
      scrap_post_hosted_images(post_page, website, scrapping, previous_scrapping_date)
    end
  end


  #TODO => SCRAPPER LES IMAGES QUI NE SONT PAS DES LIENS
  def scrap_post_direct_images(post_page, website, scrapping, previous_scrapping_date)
  	pp "Scrap post for direct images : #{post_page.title}"
    post = scrapping.posts.find_or_create_by(:name => post_page.title)
    post.update_attributes(:website => website, :status => Post::TO_SORT_STATUS)
   	
    doc = post_page.parser
    image_urls = doc.xpath('//div[@class="bodyContent"]//img').map { |i| i[:src] if allowed_formats.include?(File.extname(i[:src]))}.compact
    image_urls.each do |url|
      if Image.where(:source_url => url).first.nil?
        image = Image.new.build_info(url, website, post)
        pp "Save #{image.key}"
        image.download
        sleep(1)
      end
    end

    post.destroy if post.images.count==0
  end

  def scrap_post_hosted_images(post_page, website, scrapping, previous_scrapping_date)
    pp "Scrap post for hosted images : #{post_page.title}"
    post = scrapping.posts.find_or_create_by(:name => post_page.title)
    post.update_attributes(:website => website, :status => Post::TO_SORT_STATUS)
    
    doc = post_page.parser
    links = doc.xpath('//div[@class="bodyContent"]//a')
    base_url = YAML.load_file('config/forums.yml')["forum1"]["base_url"]
    host_urls = links.map { |i| i[:href] }.reject {|u| u.include?("profile") || Image.where(:hosting_url => u).first.present?}
    host_urls.each do |host_url|
      if host_url.include?("http")
        browser = Mechanize.new.get(host_url)
        page_images = browser.images_with(:src => /picture/, :mime_type => /jpg|jpeg|png/).reject {|s| %w(logo register banner).any? { |w| s.url.to_s.include?(w)}}
      else
        page_images=[Str.new("#{base_url}#{host_url}")]
      end
      
      page_images.each do |page_image|
        url = page_image.url.to_s
        if Image.where(:source_url => url).first.nil?
          image = Image.new.build_info(url, host_url, website, post)
          pp "Save #{image.key}"
          image.download(page_image)
          sleep(1)
        end
      end
    end

    post.destroy if post.images.count==0

    next_link = post_page.link_with(:text => "»")
    if next_link
      post_page = next_link.click
      scrap_post_hosted_images(post_page, website, scrapping, previous_scrapping_date)
    end    
  end






#########################################################################################################
#
# Forums2
#
#########################################################################################################





  desc "Scrap forum2 in forums.yml"
  task :forum2  => :environment do
    require 'open-uri'
    require 'digest/md5'

    url = YAML.load_file('config/forums.yml')["forum2"]["url"]
    website = Website.where(:url => url).first
    
    last_scrapping = Scrapping.where(:success => true, :website => website).asc(:date).limit(1).first
    previous_scrapping_date = last_scrapping.nil? ? 1.month.ago.beginning_of_month : last_scrapping.date

    new_scrapping = website.scrappings.create(:date => DateTime.now)
    start_time = DateTime.now

    user = YAML.load_file('config/forums.yml')["forum2"]["username"]
    password = YAML.load_file('config/forums.yml')["forum2"]["password"]

    pp "Sign in user : #{user}"
    home_page = Mechanize.new.get(url)

    forums_page = home_page.form_with(:name => nil) do |form|
      form.fields.first.value = user
      form.fields.second.value = password
    end.submit   

    pp "Start scrapping #{url} new images since : #{previous_scrapping_date}"

    (1..2).each do |category_number|
      category_name = YAML.load_file('config/forums.yml')["forum2"]["category#{category_number}"]
      forum_page = forums_page.link_with(:text => category_name).click
      scrap_mp_forum(forum_page, website, new_scrapping, previous_scrapping_date)
    end

    images_saved = new_scrapping.posts.inject(0) {|result, post| result + post.images.count}

    new_scrapping.update_attributes(
      success: true,
      duration: DateTime.now-start_time,
      image_count: images_saved
    )
  end


  def scrap_mp_forum(forum_page, website, scrapping, previous_scrapping_date)
    doc = forum_page.parser
    links = doc.xpath('//tr[contains(@class, "row") and not(contains(@class, "sticky"))]//td[contains(@class, "firstcol") or contains(@class, "topic-titles")]//a').map {|i| i[:href]}
    links.each do |link|
      post_page = forum_page.link_with(:href => link).click
      scrap_mp_post_direct_images(post_page, website, scrapping, previous_scrapping_date)
      scrap_mp_post_hosted_images(post_page, website, scrapping, previous_scrapping_date)
    end
  end


  def scrap_mp_post_direct_images(post_page, website, scrapping, previous_scrapping_date)
    pp "Scrap post for direct images : #{post_page.title}"
    post = scrapping.posts.find_or_create_by(:name => post_page.title)
    post.update_attributes(:website => website, :status => Post::TO_SORT_STATUS)
    
    doc = post_page.parser
    all_images = doc.xpath('//div[contains(@class, "post-body")]//img').map { |i| i[:src] if allowed_formats.include?(File.extname(i[:src]))}.compact
    images_in_link = doc.xpath('//div[contains(@class, "post-body")]//a//img').map { |i| i[:src] if allowed_formats.include?(File.extname(i[:src]))}.compact

    (all_images-images_in_link).each do |url|
      if Image.where(:source_url => url).first.nil? && !url.include?("thumb")
        image = Image.new.build_info(url, website, post)
        pp "Save #{image.key}"
        image.download
        sleep(1)
      end
    end

    post.destroy if post.images.count==0

    next_link = post_page.link_with(:text => "Next»")
    if next_link
      post_page = next_link.click
      scrap_post_hosted_images(post_page, website, scrapping, previous_scrapping_date)
    end
  end


  def scrap_mp_post_hosted_images(post_page, website, scrapping, previous_scrapping_date)
    pp "Scrap post for hosted images : #{post_page.title}"
    post = scrapping.posts.find_or_create_by(:name => post_page.title)
    post.update_attributes(:website => website, :status => Post::TO_SORT_STATUS)
    
    doc = post_page.parser
    links = doc.xpath('//div[contains(@class, "post-body")]//a')
    host_urls = links.select {|link| link.search('img').present?}.map { |link| link[:href] }.select {|s| s.include?("http")}.compact.reject {|u| Image.where(:hosting_url => u).first.present?}

    host_urls.each do |host_url|
      begin
        browser = Mechanize.new.get(host_url)
        page_images = browser.images_with(:mime_type => /jpg|jpeg|png/).reject {|s| %w(logo register banner).any? { |w| s.url.to_s.include?(w)}}

        page_images.each do |page_image|
          url = page_image.url.to_s
          if Image.where(:source_url => url).first.nil?
            image = Image.new.build_info(url, host_url, website, post)
            pp "Save #{image.key}"
            image.download(page_image)
            sleep(1)
          end
        end
      rescue StandardError => e
        Rails.logger.error e.to_s
      end
    end

    post.destroy if post.images.count==0

    next_link = post_page.link_with(:text => "Next»")
    if next_link
      post_page = next_link.click
      scrap_post_hosted_images(post_page, website, scrapping, previous_scrapping_date)
    end
  end
end
