class Evaluation < ApplicationRecord
  belongs_to :user
  belongs_to :rate, class_name: 'User'

  validates :user_id, presence: true
  validates :rate_id, presence: true
end
