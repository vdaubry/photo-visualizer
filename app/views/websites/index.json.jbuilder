json.array!(@websites) do |website|
  json.extract! website, :id, :name, :url
  json.url website_url(website, format: :json)
end
