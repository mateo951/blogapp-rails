module UsersHelper
  def get_photo(user)
    "https://ui-avatars.com/api/?name=#{user.name}&background=random"
  end
end
