Rails.application.routes.draw do  
  root 'products#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  
  resources :products, only: [:new, :create, :show, :destroy, :edit]
  resources "category", only: [:index, :show]
  resources :creditcards, only: [:index, :new, :create, :destroy]
  resources :mypage do
    collection do
      get :my_page
      get :my_page_logout
      get :my_page_credit
      get :my_page_transaction
      get :my_page_transactiond
      get :my_page_exhibition
      get :my_page_exhibiting
      get :my_page_sold
    end
  end
end
