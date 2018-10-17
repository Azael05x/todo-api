FactoryBot.define do
  factory :task do
    title { "Play with #{Faker::Dog.name}" }
  end
end
