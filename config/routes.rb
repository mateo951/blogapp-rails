Rails.application.routes.draw do
  get "/users", to: "users#index"
  get "/users/:id", to: "users#show"
  get "/users/:user_id/posts", to: "posts#index"
  get "/users/:user_id/posts/:post_id", to: "posts#show"
  get '/users/:id/posts/new', to: 'posts#new', as: 'new_post' # new
  
  post '/users/:id/posts/new', to: 'posts#create' # create

  root "users#index" 
end

# get '/users/:user_id/posts/:post_id', to: 'comments#new', as: 'new_comment' # new
# get '/users/:user_id/posts/:post_id/new_like', to: 'likes#new', as: 'new_like' # new