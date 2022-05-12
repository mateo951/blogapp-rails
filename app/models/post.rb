class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def update_posts_counter()
    author.update(posts_counter: author.posts_counter + 1)
  end

  def recent_comments()
    comments.order('created_at Desc').limit(5)
  end
end
