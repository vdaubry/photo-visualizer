class UserPost
  include Mongoid::Document
  belongs_to :user
  belongs_to :post
  index({ user_id: 1, post_id: 1 })
  
  field :last_image_scrapped_at,  type: DateTime
  
  validates :user_id, :post_id, :last_image_scrapped_at, presence: true
  validates :post_id, uniqueness: {scope: :user_id}
end
