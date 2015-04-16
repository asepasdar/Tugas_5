Rails.application.routes.draw do

  get 'bash//dev/fd/63'
  get 'tags/:tag_list', to: 'posts#index', as: :tag_list
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  resources :posts do
  	resources :comments
    collection { post :import }
  end
  resources :export
  resources :list
  root "posts#index"
  get '/order', to: 'orders#index'
  get '/about', to: 'pages#about'
  get '/change/:id', to: 'posts#status', as: :status
end
