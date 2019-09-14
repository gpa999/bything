class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :tell, class_name: 'User'

  validates :user_id, presence: true
  validates :tell_id, presence: true
end
