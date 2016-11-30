Rails.application.routes.draw do
  post 'inventory/save'
  get 'inventory/receive', as: :inventory_receive
  get 'inventory/search' => 'inventory#search'
  get 'inventory/add_serialized_to_queue', as: :add_serialized_to_queue
  get 'inventory/add_sellable_to_queue', as: :add_sellable_to_queue
  get 'inventory' => 'inventory#index'
  get 'inventory/inventory_list' => 'inventory#inventory_list'

  get 'sellables/search'
  get 'invoices/add_serialized_line_item', as: :add_serialized_line_item
  get 'invoices/add_simple_line_item', as: :add_simple_line_item
  get 'invoices/add_payment_line_item', as: :add_payment_line_item

  get 'reports/sales' => 'reports#sales'
  get 'reports/payments' => 'reports#payments'

  resources :payments, :settings, :payment_types, :serialized_items

  resources :customers do
    resources :payments, shallow: true
    resources :invoices, shallow: true
    resources :numbers, shallow: true
  end

  resources :products, :inventories, :invoices, :product_categories, :sellables, :stores, :users, :carriers, :categories

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
  get '/store_select' => 'pages#select_store'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
