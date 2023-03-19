Rails.application.routes.draw do
    
   # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }
    
  namespace :public do
    get 'menus/index'
    get 'menus/show'
  end
  namespace :public do
    get 'deliveries/index'
    get 'deliveries/show'
    get 'deliveries/edit'
  end
  namespace :public do
    get 'orders/new'
    get 'orders/index'
    get 'orders/show'
    get 'orders/check'
    get 'orders/done'
  end
  namespace :public do
    get 'cart_items/index'
    get 'cart_items/destroy_all'
  end
  namespace :public do
    get 'customers/show'
    get 'customers/edit'
    get 'customers/check'
    get 'customers/reject_customers'
  end
  namespace :public do
    get 'homes/top'
    get 'homes/about'
  end
  namespace :admin do
    get 'orders/show'
  end
  namespace :admin do
    get 'customers/index'
    get 'customers/show'
    get 'customers/edit'
  end
  namespace :admin do
    get 'genres/index'
    get 'genres/edit'
  end
  namespace :admin do
    get 'menus/new'
    get 'menus/index'
    get 'menus/show'
    get 'menus/edit'
  end
  namespace :admin do
    get 'homes/top'
  end
  devise_for :customers
  devise_for :admins
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
