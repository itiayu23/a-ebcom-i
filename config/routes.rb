 Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
     sessions: "admin/sessions"
  }
  devise_for :users, skip: [:passwords] ,controllers: {
    registrations: "user/registrations",
  sessions: 'user/sessions'
  }

  scope module: :user do
    root to: 'homes#top'
    get 'homes/about'
    resources :user_pages, only: [:index, :show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      # フォローする
      get 'followings' => 'relationships#followings', as: 'followings'
      # フォローされる
      get 'followers' => 'relationships#follwers', as: 'follwers'
    end
    get 'user/user_page/:id/check' => 'user_pages#check', as: 'check'
    patch 'user/user_page/:id/withdraw' => 'user_pages#withdraw', as: 'withdraw'
    # resources :bookmarks, only: [:index]
    resources :novels do
      resource :bookmarks, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end

    resources :picts do
      resource :pict_bookmarks, only: [:create, :destroy]
      resources :pict_comments, only: [:create, :destroy]
    end

    resources :messages, only: [:create]
    resources :rooms, only: [:create, :index, :show]

  end

  namespace :admin do
    get 'homes/top'
  end

end