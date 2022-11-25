FactoryBot.define do
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
  factory :answer_time do
    round { Faker::Number.between}
    time_millisecond { Faker::Number.between}
  end
  factory :user_sentence do
    sentence { Faker::Lorem.sentence }
    key_word { Faker::Lorem.words }
    hint { Faker::Lorem.sentence }
    comment { Faker::Lorem.sentence }
  end
  factory :user_sentence_set do
    title { Faker::Lorem.words }
    description { Faker::Lorem.paragraph }
    category {Faker::Lorem.word}
  end

end
