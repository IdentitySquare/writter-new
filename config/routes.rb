Rails.application.routes.draw do
  
     
  root to: "home#index" 

  resources :user_profiles, only: [:update, :show]

  devise_for :users,
             controllers: {
               registrations: 'users/registrations',
               confirmations: 'users/confirmations',
               sessions: 'users/sessions',
               invitations: 'users/invitations',
               omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources   :users, only: [:update]

  resources :posts, except: [:create]
  
  get '/onboarding', to: "onboarding#index"

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :onboarding, only: [] do
    collection do
        post :checkUsername
    end
  end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end