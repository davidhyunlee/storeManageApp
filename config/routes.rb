Rails.application.routes.draw do
  get 'sellables/search'
  get 'invoices/add_serialized_line_item', as: :add_serialized_line_item

  resources :customers do
    resources :payments, shallow: true
    resources :invoices, shallow: true
  end

  resources :products, :inventories, :invoices, :product_categories, :sellables

  root 'sessions#new'

  get '/add_number' => 'customers#add_number'

  get '/payments' => 'payments#index'
  # these routes are for showing users a login form, logging them in, and logging them out.
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  get '/dashboard' => 'pages#dashboard'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
