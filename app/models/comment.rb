class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post, class_name: 'Post'

  def self.update_counter(post)
    post.update(comments_counter: (post.comments_counter + 1))
  end
end
