class Post < ApplicationRecord
  belongs_to :author_id
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def update_posts_counter()
    user.update(posts_counter: user.posts_counter + 1)
  end

  def recent_comments()
    posts.limit(3)
  end
end
