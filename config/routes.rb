Rails.application.routes.draw do
  #root 'products#index'
  root 'users#my_page'
  #root 'credit_cards#index'

  resources :users do
    collection do
      get :my_page
      get :my_page_logout
      get :my_page_credit
    end
  end

  resources :card, only: [:index, :new, :create, :show, :destroy] do
    collection do
      get :index
    #  post 'show', to: 'cledit_cards#show'
    #  post 'create', to: 'cledit_cards#create'
    #  post 'delete', to: 'cledit_cards#delete'
    end
  end
end