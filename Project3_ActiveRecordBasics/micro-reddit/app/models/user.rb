# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  username   :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
    has_many :posts
    has_many :comments

    validates :username, presence: true, length: {maximum: 20}, uniqueness: true
    validates :email, presence: true, uniqueness: true

end
