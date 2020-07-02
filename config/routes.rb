Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root to: 'pages#index'

  resources :artists, only: %i[show index]

  resources :mashups, only: %i[show index update]

  resources :users, except: %i[new index]
  get 'signup', to: 'users#new', as: 'signup'

  resources :user_sessions, only: %i[create]
  get 'login', to: 'user_sessions#new', as: 'login'
  delete 'logout', to: 'user_sessions#destroy', as: 'logout'
end
