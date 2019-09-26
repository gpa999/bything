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
  has_many :wantthings
  has_one :amount
  has_many :messages
  has_many :talkings, through: :messages, source: :talk
  has_many :reverse_of_messages, class_name: 'Message', foreign_key: 'talk_id'
  has_many :talkers, through: :reverse_of_messages, source: :user
  has_many :nomalpoints
  has_many :issue_person, through: :nomalpoints, source: :issue
  has_many :reverse_of_nomalpoints, class_name: 'Nomalpoint', foreign_key: 'issue_id'
  has_many :gave_people, through: :reverse_of_nomalpoints, source: :user
  has_many :exchangepoints
  has_many :give_people, through: :exchangepoints, source: :give
  has_many :reverse_of_exchangepoints, class_name: 'Exchangepoint', foreign_key: 'give_id'
  has_many :have_people, through: :reverse_of_exchangepoints, source: :user
         
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
  
  def have_nomalpoints
    array = []
    self.nomalpoints.all.each do |e|
      if e.issue == self 
        array << e.point
      end
    end
    array.sum
  end
  
  def all_point 
    @total_evaluation = 0
    @users = User.all
    @users.each do |user|
          if user.evaluate > 0
              @total_evaluation += user.evaluate
          end
    end
    if @total_evaluation > 0 
      all_pt = 10000 * self.evaluate / @total_evaluation 
      return all_pt.floor
    else
      return 0
    end 
  end
  
  def one_point
    @total_evaluation = 0
    @users = User.all
    @users.each do |user|
          if user.evaluate > 0
              @total_evaluation += user.evaluate
          end
    end
    if @total_evaluation > 0 
      all_pt = 10000 * self.evaluate / @total_evaluation 
    else
      all_pt = 0
    end 
    if self.reverse_of_evaluations.present? && self.amount.present? 
      if self.evaluate > 0 
        onepoint = all_pt.to_f / self.amount.sheet.to_f 
        return onepoint.to_f.floor(2)
      else
        return 0
      end 
    else
      return 0
    end
  end
  
  def now_all_point
    @total_evaluation = 0
    @users = User.all
    @users.each do |user|
          if user.evaluate > 0
              @total_evaluation += user.evaluate
          end
    end
    if @total_evaluation > 0 
      all_pt = 10000 * self.evaluate / @total_evaluation 
    else
      all_pt = 0
    end 
    @exchangepoints = self.exchangepoints.all + self.reverse_of_exchangepoints.all
    @user_give_point = 0
    @user_get_point = 0 
    @exchangepoints.each do |exchangepoint|
      if self.exchangepoints.include?(exchangepoint)
        if exchangepoint.give_nomal_point.present?
            @user_give_point += exchangepoint.give_nomal_point
        end
        if exchangepoint.give_point.present?
          my_point = exchangepoint.give_point * exchangepoint.give_issue.one_point
          @user_give_point += my_point.floor
        end
        if exchangepoint.get_nomal_point.present?
            @user_get_point += exchangepoint.get_nomal_point
        end
        if exchangepoint.get_point.present?
          my_point = exchangepoint.get_point * exchangepoint.issue.one_point
          @user_get_point += my_point.floor
        end
      else
        if exchangepoint.give_nomal_point.present?
            @user_get_point += exchangepoint.give_nomal_point
        end
        if exchangepoint.give_point.present?
          my_point = exchangepoint.give_point * exchangepoint.give_issue.one_point
          @user_get_point += my_point.floor
        end
        if exchangepoint.get_nomal_point.present?
            @user_give_point += exchangepoint.get_nomal_point
        end
        if exchangepoint.get_point.present?
          my_point = exchangepoint.get_point * exchangepoint.issue.one_point
          @user_give_point += my_point.floor
        end
      end
    end
    pt = all_pt - @user_give_point + @user_get_point
    return pt
  end
  
  def give_take_nomal_point
    @total_evaluation = 0
    @users = User.all
    @users.each do |user|
          if user.evaluate > 0
              @total_evaluation += user.evaluate
          end
    end
    if @total_evaluation > 0 
      all_pt = 10000 * self.evaluate / @total_evaluation 
    else
      all_pt = 0
    end 
    @exchangepoints = self.exchangepoints.all + self.reverse_of_exchangepoints.all
    @user_give_point = 0
    @user_get_point = 0
    @exchangepoints.each do |exchangepoint|
      if self.exchangepoints.include?(exchangepoint)
        if exchangepoint.give_nomal_point.present?
            @user_give_point += exchangepoint.give_nomal_point
        end
        if exchangepoint.get_nomal_point.present?
          @user_get_point += exchangepoint.get_nomal_point
        end
      else
        if exchangepoint.give_nomal_point.present?
            @user_get_point += exchangepoint.give_nomal_point
        end
        if exchangepoint.get_nomal_point.present?
          @user_give_point += exchangepoint.get_nomal_point
        end
      end
    end
    
    pt =  @user_get_point - @user_give_point
    return pt
  end
  
  def give_take_point(other_user)
      @total_evaluation = 0
      @users = User.all
      @users.each do |user|
            if user.evaluate > 0
                @total_evaluation += user.evaluate
            end
      end
      if @total_evaluation > 0 
        all_pt = 10000 * self.evaluate / @total_evaluation 
      else
        all_pt = 0
      end 
      @get_exchangepoints = self.exchangepoints.where(issue_id: other_user.id) + self.reverse_of_exchangepoints.where(give_issue_id: other_user.id)
      @give_exchangepoints = self.exchangepoints.where(give_issue_id: other_user.id) + self.reverse_of_exchangepoints.where(issue_id: other_user.id)
      @home_points = self.nomalpoints.where(issue_id: other_user.id)
      @user_give_point = 0
      @user_get_point = 0 
      @get_exchangepoints.each do |exchangepoint|
        if self.exchangepoints.where(issue_id: other_user.id).include?(exchangepoint)
          if exchangepoint.get_point.present?
            my_point = exchangepoint.get_point
            @user_get_point += my_point.floor
          end
        else
          if exchangepoint.give_point.present?
            my_point = exchangepoint.give_point
            @user_get_point += my_point.floor
          end
        end
      end
    
    
      @give_exchangepoints.each do |exchangepoint|
        if self.exchangepoints.where(give_issue_id: other_user.id).include?(exchangepoint)
          if exchangepoint.give_point.present?
            your_point = exchangepoint.give_point 
            @user_give_point += your_point.floor
          end
        else
          if exchangepoint.get_point.present?
            your_point = exchangepoint.get_point 
            @user_give_point += your_point.floor
          end
        end
      end
    
      @user_home_point = 0
      @home_points.each do |home_point|
         @user_home_point += home_point.point.floor
      end
      pt = @user_get_point - @user_give_point - @user_home_point
      return pt
    end
   
  
  def now_point 
    now_point = self.amount.sheet + self.give_take_point(self)
    return now_point
  end
  
  def have_all_nomalpoints
    array = []
    self.nomalpoints.all.each do |e|
        array << e.point * e.issue.one_point
    end
    array.sum.floor
  end
      
end
