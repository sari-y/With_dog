Rails.application.routes.draw do



  namespace :public do
    get 'attachments/destroy'
  end
 devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}


devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

 scope module: :public do
  root 'homes#top'
  get '/about' => 'homes#about'
  get 'users/my_page/:id' => 'users#show', as:'users_my_page'
  get 'users/information/edit' => 'users#edit'
  patch 'users/information' => 'users#update'
  get 'users/confirm_withdraw' => 'users#confirm_withdraw'
  delete 'users/withdraw' => 'users#withdraw'

  resources :attachments, controller: 'attachments', only: %i[destroy]

  resources :reviews do
    resource :review_favorites, only: [:create, :destroy]
      post 'create_mini' => 'review_favorites#create_mini', as: 'create_mini'
      delete 'destroy_mini' => 'review_favorites#destroy_mini', as: 'destroy_mini'
    resources :review_comments, only: [:create, :update, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :bookmarks, only: [:index, :create, :destroy]

   resources :users do
    resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
      post 'create_mini' => 'relationships#create_mini', as: 'create_mini'
      delete 'destroy_mini' => 'relationships#destroy_mini', as: 'destroy_mini'
    end
  end



  devise_scope :user do
    post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end


  namespace :admin do

    resources :reviews, only: [:index, :show, :destroy] do
     resources :review_comments, only: [:destroy]
    end

    resources :users, only: [:index, :show, :destroy]
    resources :facility_categories, only: [:index, :create, :update, :destroy]

  end




  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
