Rails.application.routes.draw do
  
      
  root to: "home#index" 
  devise_for :users,
             controllers: {
               registrations: 'users/registrations',
               confirmations: 'users/confirmations',
               sessions: 'users/sessions',
               invitations: 'users/invitations',
               omniauth_callbacks: "users/omniauth_callbacks"
  }
  
  devise_scope :user do
    
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end