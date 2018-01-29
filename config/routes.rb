Rails.application.routes.draw do

  root 'welcome#index'

  get 'welcome/about'

  devise_for :users
  resource :user

  resources :official_articles do
    resources :article_comments
    member do
      post :like
      post :unlike
    end
    collection do
      get :search
    end
  end

  resources :nodes do
    member do
      post :block
      post :unblock
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
      get :search
      get :no_answer
      get :popular

      get :favorites
      # post :preview
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
    collection do
      get :search
    end
  end
  resources :meetup_groups do
    collection do
      get :search
      get :about
    end
  end
  resources :jobs do
    collection do
      get :search
    end
  end
  resources :sites do
    collection do
      get :search
    end
  end
  resources :courses do
    collection do
      get :search
    end
  end
  resources :projects do
    collection do
      get :search
    end
  end

  namespace :account do
    resources :users
    resources :groups
    resources :posts
    resources :topics
    resources :jobs
    resources :meetup_groups
    resources :passwords
  end

  namespace :admin do
    root to: 'home#index', as: 'root'
    resources :groups do
      collection do
        post :bulk_update
      end
      resources :posts
    end
    resources :versions do
      post :undo
    end
    resources :topics do
      member do
        post :suggest
        post :unsuggest
        post :undestroy
      end
      collection do
        post :bulk_update
      end
    end
    resources :nodes
    resources :sections
    resources :meetup_groups do
      collection do
        post :bulk_update
      end
    end
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
