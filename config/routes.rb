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
  post 'homes/guest_sign_in', to: 'homes#new_guest'
  devise_scope :customer do
    post 'customer/guest_sign_in', to: 'customer/sessions#new_guest'
  end
    resources :customers, only: [:show, :edit, :update, :index]
    resources :contributions, only: [:new, :create, :show, :index, :edit, :update, :destroy]
    resources :shops, only: [:index, :show] do
      resources :contributions, only: [:new]
    end
    
end

devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
namespace :admin do
  get 'homes/top' => 'homes#top'
  get 'homes/about' => 'homes#about'
    resources :customers, only: [:show, :index, :destroy, :edit, :update]
    resources :contributions, only: [:index, :destroy]
    resources :shops, only: [:new, :create, :show, :index, :destroy]
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
