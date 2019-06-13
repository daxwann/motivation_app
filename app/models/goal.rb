class Goal < ApplicationRecord
  include Commentable

  validates :title, :detail, presence: true
  validates :completed, :public, inclusion: { in: [true, false] }
  
  belongs_to :author,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User
end
