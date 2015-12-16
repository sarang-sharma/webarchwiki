Rails.application.routes.draw do
  
  devise_for :admins
  devise_for :users
  resources :articles
  root 'articles#index'
  get 'tags/:tag', to: 'articles#index', as: :tag
  get '*path' => redirect('/')
end
