class Website
  include Mongoid::Document
  include Mongoid::Timestamps
  
  has_many :posts, dependent: :destroy
  has_many :images, dependent: :destroy

  field :name, type: String
  field :url, type: String

  validates :name, :url, presence: true, uniqueness: true

  def latest_post
    @latest_post ||= posts.order("created_at DESC").first
  end
end
