Rails.application.routes.draw do
  
  root 'public/homes#top'
  get "homes/about" => "homes#about", as: "about"
  

# 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

resources :items, only: [:create,:index,:show,:update,:edit,:new]

resources :genres, only: [:create, :index,:edit,:update,]

resources :customers, only: [:edit, :index,:update,:show]
  get '/customers/unsubscribe'
  patch '/customers/withdraw'

resources :orders, only: [:index,:show,:update]

resources :order_details, only: [:update]

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

    namespace :admin do
      get  '/about' =>'homes#about'
      
      resources :items, only: [:index, :show,:new,:create,:edit,:update]
      
      resources :genres, only: [:index,:create,:edit, :update]
    
      resources :customers, only: [:index,:show,:edit, :update]
    
      
      resources :cart_items, only: [:create, :index,:destroy,:update]
      get'/cart_items/destroy_all'
      
      resources :orders, only: [:new,:index,:show,:create]
      get'/orders/confilm'
      
      resources :addresses, only: [:create,:edit, :index,:destroy,:updat]
    end
  end

 

