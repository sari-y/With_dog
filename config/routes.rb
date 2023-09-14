Rails.application.routes.draw do



 devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}


devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

 scope module: :public do
    get '/' => 'homes#top'
    get '/about' => 'homes#about'
    get 'users/my_page' => 'users#show'
    get 'users/information/edit' => 'users#edit'
    patch 'users/information' => 'users#update'
    get 'users/confirm_withdraw' => 'users#confirm_withdraw'
    delete 'users/withdraw' => 'users#withdraw'



    resources :reviews do
     resource :review_favorites, only: [:create, :destroy]
     resources :review_comments, only: [:create, :update, :destroy]
    end
    
    
    


  end



  namespace :admin do

    resources :reviews, only: [:index, :show, :destroy]
    resources :users, only: [:index, :show, :destroy]
    resources :facility_categories, only: [:index, :create, :update, :destroy]
    resources :review_comments, only: [:destroy]

  end




  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
