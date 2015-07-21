task "clean" => :environment do
  Website.destroy_all
end
