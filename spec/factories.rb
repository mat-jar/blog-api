FactoryBot.define do
  factory :article do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
  end
  factory :flashcard do
    front_text { Faker::Lorem.words }
    back_text { Faker::Lorem.words }
  end
  factory :flashcard_set do
    title { Faker::Lorem.words }
    description { Faker::Lorem.paragraph }
    category {Faker::Lorem.word}
  end
  factory :user do
    email { Faker::Internet.email}
    password { Faker::Internet.password}
  end
end
