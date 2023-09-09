Rails.application.routes.draw do


  namespace :admin do
    get 'facility_categories/index'
  end
  namespace :admin do
    get 'users/index'
    get 'users/show'
  end
  namespace :admin do
    get 'reviews/index'
    get 'reviews/show'
  end
  namespace :public do
    get 'reviews/new'
    get 'reviews/index'
    get 'reviews/show'
    get 'reviews/edit'
  end
  namespace :public do
    get 'users/show'
    get 'users/edit'
    get 'users/confirm'
  end
  namespace :public do
    get 'homes/top'
    get 'homes/about'
  end
 devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}


devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
