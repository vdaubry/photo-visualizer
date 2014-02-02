module WebsitesHelper

	def last_scrapping_date(website)
		website.scrappings.asc(:date).limit(1).first.date.strftime("%d/%b/%y")
	end

	def images_to_sort_count(website)
		website.images.where(:status => Image::TO_SORT_STATUS).count
	end

end
