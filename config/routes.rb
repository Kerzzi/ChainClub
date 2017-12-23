Rails.application.routes.draw do
  
  devise_for :users
  root 'welcome#index'
  resources :official_articles
  resources :groups do
    resources :posts do
      resources :comments
    end
  end
end
