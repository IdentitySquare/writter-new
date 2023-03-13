Rails.application.routes.draw do
  
     
  root to: "home#index" 
  
  resources :user_profiles, only: [:update, :show] do
    member do
      post 'follow', to: 'user_profiles#follow'
      delete 'unfollow', to: 'user_profiles#unfollow'
      get 'followers', to: 'user_profiles#followers'
      get 'following', to: 'user_profiles#following'
    end
  end

  get 'settings/notifications', to: 'user_profiles#notifications_settings', as: :notifications_settings
  
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
  get 'posts/:id/publish', to: 'posts#publish' , as: 'publish_post'
  get 'posts/:id/unpublish', to: 'posts#unpublish' , as: 'unpublish_post'

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