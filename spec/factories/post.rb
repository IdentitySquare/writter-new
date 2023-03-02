FactoryBot.define do
    
    factory :post do
      user
      body { }
      draft_body { }
      published_at { Faker::Date.between(from: Date.today, to: 365.days.from_now) }
      status { 1 }
  
    end
  end
  