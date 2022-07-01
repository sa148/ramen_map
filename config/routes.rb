Rails.application.routes.draw do
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

namespace :public do

  get 'homes/top' => 'homes#top'
  get 'homes/about' => 'homes#about'
  get 'customers/unsubscribe' => 'customers#unsubscribe'
  get 'customers/withdrawal' => 'customers#withdrawal'
  patch 'customers/withdrawal' => 'customers#withdrawal'
  post 'customers/guest_sign_in', to: 'customers/guest/sign_in#new_guest'
    resources :customers, only: [:show, :edit, :update, :index]
    resources :contributions do
      get :search, on: :member
   end
    resources :contributions, only: [:new, :create, :show, :index, :edit, :update, :destroy]
end

devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
namespace :admin do
  get 'homes/top' => 'homes#top'
  get 'homes/about' => 'homes#about'
    resources :customers, only: [:show, :index, :destroy]
    resources :contributions, only: [:new, :show, :index, :edit, :update, :destroy]
    resources :shops, only: [:new, :show, :index, :edit, :update, :destroy]
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
