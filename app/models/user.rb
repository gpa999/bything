class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :image
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :evaluations
  has_many :ratings, through: :evaluations, source: :rate
  has_many :reverse_of_evaluations, class_name: 'Evaluation', foreign_key: 'rate_id'
  has_many :comments
  has_many :tellings, through: :comments, source: :tell
  has_many :reverse_of_comments, class_name: 'Comment', foreign_key: 'tell_id'
  has_many :tellers, through: :reverse_of_comments, source: :user
  has_many :havethings
         
  def self.search(search) #ここでのself.はUser.を意味する
      if search
        where(['user_path LIKE ?', "%#{search}%"])
      else
        order("created_at DESC") #全て表示。User.は省略
      end
  end
  
  def rating?(other_user)
    self.ratings.include?(other_user)
  end
  
  def evaluate
    array = []
    self.reverse_of_evaluations.all.each do |e|
      array << e.value
    end
    array.sum
  end
end
