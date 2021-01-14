FactoryBot.define do
  factory :micropost do
    user
    title { 'title' }
    time { 3 }
    content { 'hoge' }
  end
end
