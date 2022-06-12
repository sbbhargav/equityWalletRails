Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :stocks do
    resources :transactions do
      member do
        get :purchased_trans
      end

    end

  end
  

  get '/sign_up', to: 'registrations#new'

  post '/sign_up', to: 'registrations#create'

  resources :sessions, only: [:create]

  get '/sign_in', to: 'sessions#new', as: 'login'

  delete '/logout', to: 'sessions#destroy'


  get '/dashboard', to: 'stock_dashboard#dashboard'

  get '/stock_summary', to: 'stock_dashboard#summary', as: 'summary'

  get '/stock_amount', to: 'stock_dashboard#amount' , as: 'amount'

  get '/total_stocks', to: 'stock_dashboard#total_stocks'

  get '/total_amount', to: 'stock_dashboard#total_amount'

  root 'stocks#index'




  # Defines the root path route ("/")
  # root "articles#index"
end
