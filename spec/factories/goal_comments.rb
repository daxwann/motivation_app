FactoryBot.define do
  factory :goal_comment do
    body { Faker::Lorem.paragraph }
  end
end

