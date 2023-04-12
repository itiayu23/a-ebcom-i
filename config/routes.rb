 Rails.application.routes.draw do

  # namespace :admin do
  #   get 'homes/top'
  #   get 'homes/about'
  # end
  # namespace :user do
  #   get 'homes/top'
  #   get 'homes/about'
  # end
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
    get 'user_pages/check'
    # resources :bookmarks, only: [:index]
    resources :novels do
      resource :bookmarks, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end

    resources :picts do
      resource :bookmarks, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    
    resources :messages, only: [:create]
    resources :rooms, only: [:create, :index,]

  end

  namespace :admin do
    get 'homes/top'
  end

  namespace :user do
    get 'user_pages/index'
    get 'user_pages/show'
    get 'user_pages/edit'

  end
  namespace :user do
    get 'picts/new'
    get 'picts/show'
    get 'picts/index'
    get 'picts/edit'
  end
  

  namespace :admin do
    get 'homes/top'
  end

  namespace :user do
    get 'user_pages/index'
    get 'user_pages/show'
    get 'user_pages/edit'

  end
  namespace :user do
    get 'picts/new'
    get 'picts/show'
    get 'picts/index'
    get 'picts/edit'
  end
  namespace :user do
    get 'novels/new'
    get 'novels/show'
    get 'novels/index'
    get 'novels/edit'
  end
  
end