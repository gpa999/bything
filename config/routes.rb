Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  authenticated :user do
    root "top#index"
  end
  root "users#login_form"
  resources :users
  patch   'users/image/:id'  => 'users#image_update'
end
