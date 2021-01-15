FactoryBot.define do
  factory :genre do
    sequence(:name) { |n| "genre_name_#{n}" }
  end
end
