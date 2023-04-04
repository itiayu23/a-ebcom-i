Rails.application.routes.draw do
 
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
  end
  
  namespace :admin do
    get 'homes/top'
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
