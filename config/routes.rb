Rails.application.routes.draw do
  devise_for :users
  root 'mypage#my_page'

  resources :mypage do
    collection do
      get :my_page
      get :my_page_logout
      get :my_page_credit
    end
  end

  resources :products, only: [:new, :create]

  resources :creditcards, only: [:index, :new, :create, :destroy]
    #collection do
      #post 'show', to: 'card#show'
      #post 'index', to: 'card#pay'
      #post 'delete', to: 'card#delete'
    #end
end
