class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def update_posts_counter()
    user.update(posts_counter: user.posts_counter + 1)
  end

  def recent_comments()
    comments.last(5)
  end
end
