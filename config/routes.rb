Rails.application.routes.draw do
  get 'consultations/index'
  get 'consultations/new'
  get 'consultations/show'
  get 'consultations/edit'
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

end
