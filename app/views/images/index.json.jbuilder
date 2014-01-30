json.array!(@images) do |image|
  json.extract! image, :id, :key, :hash, :statut, :file_size, :width, :height, :source_url
  json.url image_url(image, format: :json)
end
