namespace :image do

  desc "Move images to their respective folders"
  task :sort  => :environment do
    raise "Cannot sort images when calinours safety is on !!" if Image.first.key == "calinours.jpg"

    pp "Deleting #{Image.where(:status => Image::TO_DELETE_STATUS).count} images"
    Image.where(:status => Image::TO_DELETE_STATUS).each do |image|
      FileUtils.rm "#{Image.image_path}/#{image.key}"
      FileUtils.rm "#{Image.thumbnail_path}/#{image.key}"
    end

    pp "Saving #{Image.where(:status => Image::TO_KEEP_STATUS).count} images"
    Image.where(:status => Image::TO_KEEP_STATUS).each do |image|
      FileUtils.mv "#{Image.image_path}/#{image.key}", "ressources/to_keep/#{image.key}"
      FileUtils.rm "#{Image.thumbnail_path}/#{image.key}"
    end

    Image.where(:status => Image::TO_KEEP_STATUS).update_all(:status => Image::KEPT_STATUS)
    Image.where(:status => Image::TO_DELETE_STATUS).update_all(:status => Image::DELETED_STATUS)
  end
end