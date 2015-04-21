Rails.application.routes.draw do
  get 'tags/:tag_list', to: 'posts#index', as: :tag_list
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  resources :posts do
  	resources :comments
    collection { post :import }
  end
  resources :export
  root "posts#index"
  get '/list', to: 'posts#list'
  get '/order', to: 'orders#index'
  get '/about', to: 'pages#about'
  get '/change/:id', to: 'posts#status', as: :status

  #Error Pages
  match '/404', to: 'errors#file_not_found', via: :all
  match '/422', to: 'errors#unprocessable', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

end
