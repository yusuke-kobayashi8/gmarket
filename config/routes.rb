Rails.application.routes.draw do
  #root 'products#index'
  get 'login' => "users#my_page"
  post 'login' => "users#my_page"
  delete "logout" => "users#logout"
  #root 'users#my_page'

  root 'credit_cards#show'

  resources :users do
    collection do
      get :my_page
      get :my_page_logout
      get :my_page_credit
      get :credit_register
    end
  end
end