class Post < ApplicationRecord
    belongs_to :author_id
    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy
end
