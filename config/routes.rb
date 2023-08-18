Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users
  resources :accounts
  resources :transactions

  post 'deposite', to: "users#deposite" 

  post 'withdraw', to: "users#withdraw"

  post 'transfer', to: "users#transfer"

  get "all_transactions", to: "transactions#all_transactions"

  

end
