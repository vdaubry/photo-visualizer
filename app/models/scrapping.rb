class Scrapping
  include Mongoid::Document
  field :date, type: Time
  field :duration, type: Integer
  field :website, type: String
  field :image_count, type: Integer
  field :success, type: Boolean

  validates_uniqueness_of :website, :scope => :date

  index({ website: 1, date: 1 }, { unique: true })
end
