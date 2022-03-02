Rails.application.routes.draw do
  devise_for :users

  get '/users/:user_id/posts/:post_id/destroy_comment', to: 'comments#destroy', as: 'destroy_comment' # destroy
  get '/users/:user_id/posts/:post_id/destroy_post', to: 'posts#destroy', as: 'destroy_post' # destroy

  get '/users/:id/posts/new', to: 'posts#new', as: 'new_post' # new
  get '/users/:user_id/posts/:post_id/new_like', to: 'likes#new', as: 'new_like' # new
  get '/users/:user_id/posts/:post_id/comment', to: 'comments#new', as: 'new_comment' # new

  get "/users", to: "users#index"
  get "/users/:id", to: "users#show"
  get "/users/:user_id/posts/:post_id", to: "posts#show"
  get "/users/:user_id/posts", to: "posts#index"
  
  post '/users/:user_id/posts/:post_id/destroy_comment', to: 'comments#destroy' # destroy
  post '/users/:id/posts/new', to: 'posts#create' # create
  post '/users/:user_id/posts/:post_id/comment', to: 'comments#create' # create
  post '/users/:user_id/posts/:post_id/new_like', to: 'likes#create' # create

  root "users#index" 
end
