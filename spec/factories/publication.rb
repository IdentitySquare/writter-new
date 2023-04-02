FactoryBot.define do
    
    factory :publication do
      name { Faker::Name.name }
      bio { Faker::Lorem.paragraph }
    end
  end
  