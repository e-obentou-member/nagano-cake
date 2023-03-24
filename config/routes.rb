Rails.application.routes.draw do

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    root to: 'homes#top'
    get 'homes/about'
    resources:menus, only: [:index, :show]
    get 'customers/mypage/edit' => 'customers#edit'
    patch 'customers/mypage' => 'customers#update'
    get 'customers/mypage' => 'customers#show'
    get 'customers/check'
    patch 'customers/withdraw'
    delete 'cart_items/destroy_all'
    resources:cart_items, only: [:index, :update, :destroy, :create]
    post 'orders/check'
    get 'orders/done'
    resources:orders,only: [:new,:create,:index,:show]
    resources:deliveries,only: [:index, :edit, :create, :update, :destroy]
  end

  namespace :admin do
    get '/' => 'homes#top'
    resources:menus,only:[:new, :index, :create, :show, :edit, :update]
    resources:genres,only: [:index, :create, :edit, :update]
    resources:customers,only:[:index, :show, :edit, :update]
    resources:orders,only:[:show, :update]
    resources:oder_details,only:[:update]
  end





  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
