Rails.application.routes.draw do

  root 'official_articles#index'
  devise_for :users
  resource :user

  resources :official_articles do
    resources :article_comments
  end
  
  resources :nodes do
    member do
      post :block
      post :unblock
    end
  end
  
  get 'topics/node:id', to: 'topics#node', as: 'node_topics'
  
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
  resources :courses
  resources :projects

  namespace :admin do
    root to: 'home#index', as: 'root'
    resources :versions do
      post :undo
    end
    resources :topics
    resources :nodes
    resources :sections
    resources :projects do
      collection do
        post :bulk_update
      end
      resource :project_grade, :controller => "project_grades"
    end
    resources :article_categories do
      collection do
        post :bulk_update
      end
    end
    resources :official_articles do
      collection do
        post :bulk_update
      end
    end
    resources :jobs do
      collection do
        post :bulk_update
      end
    end
    resources :site_nodes do
      collection do
        post :bulk_update
      end
    end
    resources :sites do
      collection do
        post :bulk_update
      end
    end
    resources :users do
      resource :profile, :controller => "user_profiles"
      collection do
        post :bulk_update
      end
    end
    resources :courses do
      collection do
        post :bulk_update
      end
    end
  end
end
