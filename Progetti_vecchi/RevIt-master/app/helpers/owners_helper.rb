module OwnersHelper
  # Returns the Gravatar for the given user.
  def gravatar_for(owner)
    gravatar_id = Digest::MD5::hexdigest(owner.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: owner.name, class: "gravatar")
  end
end
