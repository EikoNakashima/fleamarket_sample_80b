Rails.application.routes.draw do
  get 'card/new'
  get 'card/show'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  devise_scope :user do
    get 'delivery_address', to: 'users/registrations#new_delivery_address'
    post 'delivery_address', to: 'users/registrations#create_delivery_address'
    delete 'destroy_user_session', to: 'users/sessions#destroy'
  end
  root 'items#index'
  resources :items do
    collection do
      get 'purchases'
    end
  end
  resources :users, only: :show
  resources :card, only: [:index, :new, :create, :destroy] do
    # collection do
    #   post 'show', to: 'card#show'
    #   post 'pay', to: 'card#pay'
    #   post 'delete', to: 'card#delete'
    # end
  end
end