Rails.application.routes.draw do
  
  devise_for :admins
  devise_for :users
  resources :articles do
  	 get :autocomplete_tag_name, :on => :collection
  	end
  root 'articles#index'
  get 'tags/:tag', to: 'articles#index', as: :tag
  get '*path' => redirect('/')
end
