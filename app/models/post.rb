class Post
  TO_SORT_STATUS="TO_SORT_STATUS"
  SORTED_STATUS="SORTED_STATUS"

  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :status, type: String
  has_many :images
  embedded_in :scrapping
  embedded_in :website
  
  validate do |post|
    post.errors.add :name, 'must be unique' if Scrapping.where(:id => post.scrapping.id, "posts.name" => post.name).count > 0
  end

  validates_inclusion_of :status, in: [ TO_SORT_STATUS, SORTED_STATUS ]
end
