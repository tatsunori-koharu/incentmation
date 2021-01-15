Rails.application.routes.draw do
  get 'users/show'
  root to: "home#top"

  resources :home do
    collection do
      get 'search'
    end
  end

  devise_for :users, controllers: {
          omniauth_callbacks: 'users/omniauth_callbacks',
          registrations: 'users/registrations'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  
  resources :users, only: [:new, :show]

  resources :articles do
    resources :article_comments, only: :create
    resources :article_likes, only: [:create, :destroy]
    member do
      delete :purge
    end
  end

  resources :consultations do
    resources :consultation_comments, only: :create
    resources :consultation_fixes, only: [:create, :destroy]
    member do
      delete :purge
    end
  end

  resources :promotions do
    resources :promotion_comments, only: :create
    resources :promotion_likes, only: [:create, :destroy]
    member do
      delete :purge
    end
  end

  resources :chats, only: [:new, :create, :show, :update] do
    resources :chat_messages, only: [:create]
  end

  resources :donkeykings, only: [:new, :create]

  resources :categorys, only: [:show]

end
