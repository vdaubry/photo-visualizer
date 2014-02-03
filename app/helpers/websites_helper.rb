module WebsitesHelper

	def last_scrapping_date(website)
		if website.scrappings.blank?
			"-"
		else
			website.scrappings.asc(:date).limit(1).first.date.strftime("%d/%b/%y")
		end
	end

	def images_to_sort_count(website)
		if website.scrappings.blank?
			"-"
		else
			website.images.where(:status => Image::TO_SORT_STATUS).count
		end
	end

end
