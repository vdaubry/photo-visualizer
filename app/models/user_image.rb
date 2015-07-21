class UserImage
  include Mongoid::Document
  belongs_to :user
  belongs_to :image
  index({ user_id: 1, image_id: 1 })

  validates :user_id, :image_id, presence: true
  validates :image_id, uniqueness: {scope: :user_id}
end