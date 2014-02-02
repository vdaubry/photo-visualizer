class Image
  TO_KEEP_STATUS="TO_KEEP_STATUS"
  TO_SORT_STATUS="TO_SORT_STATUS"
  TO_DELETE_STATUS="TO_DELETE_STATUS"
  DELETED_STATUS="DELETED_STATUS"
  KEPT_STATUS="KEPT_STATUS"

  include Mongoid::Document
  include Mongoid::Timestamps
  field :key, type: String
  field :image_hash, type: String
  field :status, type: String
  field :file_size, type: Integer
  field :width, type: Integer
  field :height, type: Integer
  field :source_url, type: String

  validates :key, :image_hash, :status, :file_size, :width, :height, :source_url, presence: true, allow_blank: false, allow_nil: false
  validates_inclusion_of :status, in: [ TO_KEEP_STATUS, TO_SORT_STATUS, TO_DELETE_STATUS, DELETED_STATUS, KEPT_STATUS ]

  def key
    Rails.env.development? ? "calinours.jpg" : key
  end
end
