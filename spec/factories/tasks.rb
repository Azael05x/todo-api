FactoryBot.define do
  factory :task do
    title { "Play with #{Faker::Dog.name}" }

    factory :task_with_tags do
      tags { build_list :tag, rand(1..3) }
    end
  end
end
