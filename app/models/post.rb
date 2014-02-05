class Post
  TO_SORT_STATUS="TO_SORT_STATUS"
  SORTED_STATUS="SORTED_STATUS"

  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :status, type: String, default: Post::TO_SORT_STATUS
  has_many :images
  embedded_in :scrapping
  embedded_in :website
  
  validate do |post|
    post.errors.add :name, 'must be unique' if post.scrapping.present? && Scrapping.where(:id => post.scrapping.id, "posts.name" => post.name).count > 0
  end

  validates_inclusion_of :status, in: [ TO_SORT_STATUS, SORTED_STATUS ]

  def check_status!
    self.update_attributes(:status => Post::SORTED_STATUS) if self.images.where(:status => Image::TO_SORT_STATUS).count == 0
  end
end
