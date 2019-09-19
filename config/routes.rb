Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  authenticated :user do
    root "top#index"
  end
  root "users#login_form"
  resources :users 
  patch   'users/image/:id'  => 'users#image_update'
  resources :users do 
    resources :evaluations, only: [:create, :update]
  end
  resources :users do 
    resources :comments, only: [:create]
  end
  resources :users do 
    resources :havethings, only: [:create, :index, :update, :show, :new, :destroy]
  end
  resources :users do 
    resources :wantthings, only: [:create, :index, :update, :show, :new, :destroy]
  end
  
  resources :users do 
    resources :amounts, only: [:create, :update]
  end
  
  resources :users do 
    resources :messages, only: [:create, :new, :index, :update, :show]
    member do
      get 'send_messages'
    end
  end
  
end
