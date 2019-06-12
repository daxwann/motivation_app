class GoalComment < ApplicationRecord
  validates :body, presence: true

  belongs_to :goal,
    primary_key: :id,
    foreign_key: :goal_id,
    class_name: :Goal

  belongs_to :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :User
end
