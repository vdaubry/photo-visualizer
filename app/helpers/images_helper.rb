module ImagesHelper
  def image_link(image)
    if SAFE_MODE 
      NGINX_URL+"/images/to_sort/thumbnails/300/calinours.jpg"
    else
      NGINX_URL+"/images/to_sort/thumbnails/300/"+image["key"]
    end
  end
end
