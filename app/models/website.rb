class Website
  include Mongoid::Document
  include Mongoid::Timestamps
  has_many :images
  has_many :scrappings

  field :name, type: String
  field :url, type: String
end
