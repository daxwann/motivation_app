class UserComment < ApplicationRecord
  validates :body, presence: true

  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  belongs_to :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :User
end
