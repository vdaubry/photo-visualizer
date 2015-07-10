class Website
  include Mongoid::Document
  include Mongoid::Timestamps
  
  has_many :posts
  has_many :images

  field :name, type: String
  field :url, type: String

  validates :name, :url, presence: true
end
