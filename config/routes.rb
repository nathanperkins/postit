PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  # get '/posts', to: 'posts#index'
  # get '/posts/:id', to: 'posts#show'
  # get '/posts/new', to: 'posts#new'
  # post '/posts', to: 'posts#create'
  # get '/posts/:id/edit', to: 'posts#edit'
  # patch '/posts/:id', to: 'posts#update'
  # delete 'posts/:od' to: 'posts#destroy'

  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/pin', to: 'sessions#pin'
  post '/pin', to: 'sessions#pin'

  resources :posts, except: [:destroy] do
    member do
      post :vote #/posts/3/vote
    end

    resources :comments, only: [:create] do
      member do
        post :vote
      end
    end
  end

  resources :users, only: [:show, :create, :edit, :update]
  resources :categories, only: [:show, :new, :create]
end
