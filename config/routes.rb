Rails.application.routes.draw do
  get 'users/show'
  root to: "home#top"
  devise_for :users, controllers: {
          registrations: 'users/registrations'
  }
end
