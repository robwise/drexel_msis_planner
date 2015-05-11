module GravatarHelper
  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_url_for(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=40&d=mm"
    gravatar_url
  end
end
