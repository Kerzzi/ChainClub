Rails.application.routes.draw do

  root 'official_articles#index'
  devise_for :users
  resource :user

  resources :official_articles do
    resources :article_comments
    member do
      post :like
      post :unlike
    end
  end
  
  resources :nodes do
    member do
      post :block
      post :unblock
    end
  end

  resource :setting do
    member do
      get :account
      get :password
      get :profile
      get :reward
    end
  end
  
  get 'topics/node:id', to: 'topics#node', as: 'node_topics'
  
  resources :topics do
    member do
      post :answer
      post :favorite
      delete :unfavorite
      post :follow
      delete :unfollow
      get :ban
      post :action
      post :like
      post :unlike
    end
    collection do
      get :no_answer
      get :popular
      get :excellent
      get :favorites
      post :preview
    end
    resources :answers do
      member do
        get :answer_to
      end
    end
  end
  resources :post_comments
  resources :groups do
    member do
      post :join
      post :quit
    end
    resources :posts do
      resources :post_comments
    end
  end
  resources :meetup_groups
  resources :jobs do
    collection do
      get :search
    end
  end
  resources :sites
  resources :courses
  resources :projects
  
  namespace :account do
    resources :groups
    resources :posts
  end
  
  namespace :admin do
    root to: 'home#index', as: 'root'
    resources :versions do
      post :undo
    end
    resources :topics do
      member do
        post :suggest
        post :unsuggest
        post :undestroy
      end
    end
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
      member do
        post :publish
        post :hide
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
