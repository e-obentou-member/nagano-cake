Rails.application.routes.draw do
  
  # デバイスの記述がかぶっていたからルートのエラーが出ていたので
  # コメントアウトしました。
  # また、デバイス関連のるーとが下だと、カスタマーのところでかぶっちゃうから
  # 上に移動しました。
  
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
    # resources:registrations, only: [:new, :edit]
    # resources:sessions, only: [:new, :create, :destroy]
    resources:customers, only: [:show, :edit, :update]
    get 'edit_check'
    post 'reject_customer'
    resources:cart_items, only: [:index, :update, :destroy, :destroy_all]
    resources:delivelies,only: [:index, :edit, :update]
  end

  scope module: :admin do
    # resources:sessions,only:[:new, :create, :destroy]
    get "homes/top"
    # root to: 'homes#top'
    resources:menus,only:[:new, :index, :show, :edit, :update]
    resources:genres,only: [:index, :create, :edit, :update]
    resources:customer,only:[:index, :show, :edit, :update]
    resources:orders,only:[:show, :update]
    resources:oder_details,only:[:update]
  end




  #devise_for :customers
  #devise_for :admins
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
