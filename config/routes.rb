Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout' }, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  resources :calculations
  root to: 'home#index'
  get 'logout', to: 'home#logout'
end
