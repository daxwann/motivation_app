FactoryBot.define do
  factory :goal do
    title { Faker::Verb.base }
    detail { Faker::Lorem.sentences(2) }
  end
end
