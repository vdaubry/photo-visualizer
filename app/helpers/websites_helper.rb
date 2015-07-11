module WebsitesHelper
  def website_add_remove_link(website)
    if current_user.has_website?(website: website)
      link_to "Remove", user_website_path(website), method: "delete", class: "btn btn-danger"
    else
      link_to "Add", user_website_path(website), method: "put", class: "btn btn-success"
    end
  end
end