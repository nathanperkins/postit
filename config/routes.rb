PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  # get '/posts', to: 'posts#index'
  # get '/posts/:id', to: 'posts#show'
  # get '/posts/new', to: 'posts#new'
  # post '/posts', to: 'posts#create'
  # get '/posts/:id/edit', to: 'posts#edit'
  # patch '/posts/:id', to: 'posts#update'
  # delete 'posts/:od' to: 'posts#destroy'

  resources :posts, except: [:destroy] do
    resources :comments, only: [:create]
  end

  resources :users, except: [:index, :destroy]
  resources :categories, only: [:show, :new, :create]
end
