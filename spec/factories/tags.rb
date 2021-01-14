FactoryBot.define do
  factory :tag do
    sequence(:name) { |n| "tag_name_#{n}" }
  end
end
