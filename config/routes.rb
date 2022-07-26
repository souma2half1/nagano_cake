Rails.application.routes.draw do
  
  
  
  root 'public/homes#top'
  get "homes/about" => "homes#about", as: "about"
  

# 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

scope module: :public do

  resources :items, only: [:create,:index,:show,:update,:edit,:new]
  
  resources :cart_items,only: [:index,:update,:destroy,:create]
  delete'cart_items/destroy_all'=>'cart_items#destroy_all'
  
  resources :genres, only: [:create, :index,:edit,:update,]
  
  get'customers/infomation/edit'=>'customers#edit'
  patch'customers/infomation/'=>'customers#update'
  get'customers/my_page/' => 'customers#show',as: "my_page"
  get 'customers/unsubscribe'=> 'customers#unsubscribe',as: "unsubscribe"
  patch 'customers/withdraw',as: "withdraw"
  

  resources :orders, only: [:index,:show,:create,:new]
  get'orders/complete'=>'orders#complete',as: "complite"
  post'orders/confilm'=>'orders#confilm',as: "confilm"
  
  resources :order_details, only: [:update]
  
  resources :addresses

end

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

    namespace :admin do
      get 'admin' => 'admin/homes#top'
      get  'about' =>'homes#about'
      
      resources :items, only: [:index, :show,:new,:create,:edit,:update]
      
      resources :genres, only: [:index,:create,:edit, :update]
    
      resources :customers, only: [:index,:show,:edit, :update]
    
      
      resources :cart_items, only: [:create, :index,:destroy,:update]
      get'cart_items/destroy_all'
      
      resources :orders, only: [:new,:index,:show,:create]
      get'orders/confilm'
      
      resources :addresses, only: [:create,:edit, :index,:destroy,:updat]
    end
  end

 

