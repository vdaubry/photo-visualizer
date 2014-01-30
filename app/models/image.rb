class Image
  include Mongoid::Document
  field :key, type: String
  field :hash, type: String
  field :statut, type: String
  field :file_size, type: Integer
  field :width, type: Integer
  field :height, type: Integer
  field :source_url, type: String
end
