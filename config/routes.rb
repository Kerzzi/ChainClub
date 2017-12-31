Rails.application.routes.draw do
  
  root 'official_articles#index'
  devise_for :users
  resource :user
  
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
  resources :jobs
  resources :sites
  namespace :admin do
    resources :article_categories
    resources :official_articles do
      collection do
        post :bulk_update
      end
    end
    resources :jobs
    resources :site_nodes
    resources :sites
    resources :users do
      resource :profile, :controller => "user_profiles"
    end
  end
end
