FactoryBot.define do
    password = Faker::Internet.password(min_length: 8)
    factory :user do
      name { Faker::Name.name }
      email { Faker::Internet.email }
      username { Faker::Internet.user_name(specifier: 5..20) }
      password { password }
      password_confirmation { password }
     
     
      factory :invited_user, class: User do
        invitation_token { Faker::Internet.device_token }
      end
      
  
    end
  end
  