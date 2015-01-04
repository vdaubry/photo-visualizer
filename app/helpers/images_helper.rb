module ImagesHelper
  def image_set_tag(source, srcset = {}, options = {})
    srcset_str = "#{srcset['1X']} 1x, #{srcset['2X']} 2x"
    image_tag(source, options.merge(srcset: srcset_str))
  end
end
