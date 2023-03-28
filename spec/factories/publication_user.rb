FactoryBot.define do
  factory :publication_user do
    user
    publication
    role { 0 }
  end
end