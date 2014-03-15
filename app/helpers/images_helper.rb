module ImagesHelper
  def image_link(image)
    if SAFE_MODE 
      NGINX_THUMBNAILS_URL+"calinours.jpg"
    else
      NGINX_THUMBNAILS_URL+image["key"]
    end
  end
end
