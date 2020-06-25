Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root to: 'pages#index'

  resources :users, except: %i[new index]
  get 'signup', to: 'users#new'
end
