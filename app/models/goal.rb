class Goal < ApplicationRecord
  validates :title, :detail, presence: true
  validates :completed, :public, inclusion: { in: [true, false] }
  
  belongs_to :author,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :comments,
    primary_key: :id,
    foreign_key: :goal_id,
    class_name: :GoalComment,
    dependent: :destroy
end
