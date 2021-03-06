# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  post_id    :integer
#  body       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  like_count :integer          default("0")
#
# Indexes
#
#  index_comments_on_post_id  (post_id)
#  index_comments_on_user_id  (user_id)
#

class Comment < ApplicationRecord
  include Likable
  belongs_to :user
  belongs_to :post, counter_cache: true
  has_many :likes, -> { Like.comment }, foreign_key: :type_id, inverse_of: :comment, dependent: :destroy
  scope :paginate, ->(per_page, page_num) { limit(per_page).offset((page_num - 1) * per_page) }
end
