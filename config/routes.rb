Rails.application.routes.draw do
  
  devise_for :users
  root 'official_articles#index'
  resources :official_articles do
    resources :article_comments
  end
  resources :topics do
    resources :answers
  end
  resources :comments 
  resources :groups do
    resources :posts
  end
  resources :meetup_groups
end
