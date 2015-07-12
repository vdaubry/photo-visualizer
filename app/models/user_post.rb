class UserPost
  include Mongoid::Document
  belongs_to :user, index: true
  belongs_to :post, index: true
  
  field :last_image_scrapped_at,  type: DateTime
  
  validates :user_id, :post_id, :last_image_scrapped_at, presence: true
  validates :post_id, uniqueness: {scope: :user_id}
end
