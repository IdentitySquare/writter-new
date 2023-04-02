FactoryBot.define do
  factory :follow do
    trait :for_user do
      association :followable, factory: :user
    end

    trait :for_publication do
      association :followable, factory: :publication
    end
  end
end

