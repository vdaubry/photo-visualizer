class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :status, type: String
  field :date, type: String
  has_many :images
  embedded_in :scrapping
  embedded_in :website
  
  validate do |post|
    post.errors.add :name, 'must be unique' if Scrapping.where(:id => post.scrapping.id, "posts.name" => post.name).count > 0
  end
end
