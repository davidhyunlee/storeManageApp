Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  
  post 'inventory/save'
  get 'inventory/receive', as: :inventory_receive
  get 'inventory/search' => 'inventory#search'
  get 'inventory/add_serialized_to_queue', as: :add_serialized_to_queue
  get 'inventory/add_sellable_to_queue', as: :add_sellable_to_queue
  get 'inventory' => 'inventory#index'
  get 'inventory/inventory_list' => 'inventory#inventory_list'
  get 'inventory/simple_inventory' => 'inventory#simple_inventory', as: :simple_inventory
  get 'inventory/serialized_inventory' => 'inventory#serialized_inventory', as: :serialized_inventory

  get 'sellables/search'
  get 'sellables/get_list'
  get 'invoices/add_serialized_line_item', as: :add_serialized_line_item
  get 'invoices/add_simple_line_item', as: :add_simple_line_item
  get 'invoices/add_payment_line_item', as: :add_payment_line_item

  get 'reports/sales' => 'reports#sales'
  get 'reports/payments' => 'reports#payments'

  get 'payments/carrier_and_payment_types' => 'payments#carrier_and_payment_types'

  resources :payments, :settings, :payment_types, :serialized_items, :products, :inventories, :product_categories, :sellables, :stores, :users, :carriers, :categories, :performance_categories

  resources :plans do
    collection do
      get 'search'
    end
  end

  resources :invoices do
    collection do
      get 'add_plan'
      get 'add_plan_line_item'
      get 'search_items'
      get 'search_serialized'
      get 'search_simple'
      get 'add_item'
    end
  end

  resources :customers do
    resources :payments, shallow: true
    resources :invoices, shallow: true
    resources :numbers, shallow: true
  end

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
