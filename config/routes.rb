Rails.application.routes.draw do
  devise_for :users
  root 'mypage#my_page'

  resources :products, only: [:new, :create]
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
      get :new
    end
  end
end
