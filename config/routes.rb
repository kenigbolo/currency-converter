Rails.application.routes.draw do
  devise_for :users
  resources :calculations
	root to: "home#index"
end
