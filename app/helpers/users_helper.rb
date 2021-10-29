module UsersHelper
  # Returns the Gravatar for the given user.
  def gravatar_for user, size: 80
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_base_url = "https://secure.gravatar.com/avatar/"
    gravatar_url = gravatar_base_url + "#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
