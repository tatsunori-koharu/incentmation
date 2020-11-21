Rails.application.routes.draw do
  get 'users/show'
  root to: "home#top"
  devise_for :users, controllers: {
          omniauth_callback: 'users_omniauth_callbacks',
          registrations: 'users/registrations'
  }
end
