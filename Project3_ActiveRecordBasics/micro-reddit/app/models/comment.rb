# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  post_id    :integer
#
# Indexes
#
#  index_comments_on_post_id  (post_id)
#

class Comment < ActiveRecord::Base
    belongs_to :user
    belongs_to :post

    validates :user_id, presence: true
    validates :post_id, presence:true
end
