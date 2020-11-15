Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'delivery_address', to: 'users/registrations#new_delivery_address'
    post 'delivery_address', to: 'users/registrations#create_delivery_address'
  end
  root 'items#index'
  resources :items do
    collection do
      get 'purchases'
    end
  end
  resources :users, only: :show
  resources :categories, only: [:index] do
    member do
      get 'parent'
      get 'child'
      get 'grandchild'
    end
  end
end