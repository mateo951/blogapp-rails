class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post, class_name: 'Post'

  def self.update_counter(post)
    post.update(likes_counter: (post.likes_counter + 1))
  end
end
