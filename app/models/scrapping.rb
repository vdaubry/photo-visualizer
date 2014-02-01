class Scrapping
  include Mongoid::Document
  field :date, type: Time
  field :duration, type: Integer
  field :website, type: String
  field :image_count, type: Integer
  field :success, type: Boolean
end
