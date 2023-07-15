Rails.application.routes.draw do
  resources :groups do 
    resources :settlements
  end
  devise_for :users
  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy', as: :Logout
  end 
  root to: 'users#index'
  
end
