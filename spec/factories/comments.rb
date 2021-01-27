FactoryBot.define do
  factory :comment do
    user
    micropost
    content { 'hoge' }
  end
end
