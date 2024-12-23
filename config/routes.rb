Rails.application.routes.draw do
  root "home#index"

  resources :sessions, only: [:new, :create, :destroy]

  resources :users, only: [:new, :create, :show, :update, :edit] do
    member do
      get :edit_account
      patch :update_account
      get :edit_profile
      patch :update_profile
    end
  end

  # 予約単独
  resources :reservations, only: [:index, :new, :create, :edit, :update, :destroy]

  # 施設単独、施設に関する予約のルーティング
  resources :rooms do
    resources :reservations, only: [:index, :new, :create, :edit, :update, :destroy]
  end

    # ユーザー登録ページのルーティング（signup）
    get '/signup', to: 'users#new', as: 'signup'
    post '/signup', to: 'users#create'

    # ログイン関連
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
end
