Rails.application.routes.draw do
  
  devise_for :users
  root 'welcome#index'
  resources :groups do
    resources :posts do
      resources comments
    end
  end
end
