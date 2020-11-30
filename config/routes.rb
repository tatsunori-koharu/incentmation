Rails.application.routes.draw do
  get 'users/show'
  root to: "home#top"
  devise_for :users, controllers: {
          omniauth_callbacks: 'users/omniauth_callbacks',
          registrations: 'users/registrations'
  }
  
  resources :users, only: [:new, :show]

  resources :articles do
    resources :article_comments, only: :create
    resources :article_likes, only: [:create, :destroy]
  end

  resources :consultations do
    resources :consultation_comments, only: :create
    resources :consultation_fixes, only: [:create, :destroy]
  end

  resources :promotions do
    resources :promotion_comments, only: :create
  end

end
