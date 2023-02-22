FactoryBot.define do
  factory :follow do
    user
    for_user
    trait :for_user do
      association :followable, factory: :user
    end
  end
end

