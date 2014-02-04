class Website
  include Mongoid::Document
  include Mongoid::Timestamps
  has_many :images
  has_many :scrappings
  embeds_many :posts

  field :name, type: String
  field :url, type: String

  # def new_monthly_scrapping
  # 	last_scrapping = self.scrappings.where(:success => true).asc(:date).limit(1).first
  # 	previous_month = 1.month.ago.beginning_of_month
  # 	if last_scrapping
  # 		previous_month = (last_scrapping.date - 1.month).beginning_of_month
  # 	end
  # 	scrapping = self.scrappings.find_or_create_by(:date => previous_month)
  # 	scrapping
  # end

end
