FactoryBot.define do
  factory  :user_comment do
    body { Faker::Lorem.paragraph }
  end
end
