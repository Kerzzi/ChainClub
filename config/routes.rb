Rails.application.routes.draw do
  
  devise_for :users
  root 'official_articles#index'
  resources :official_articles do
    resources :article_comments
  end
  resources :groups do
    resources :posts do
      resources :comments
    end
  end
end
