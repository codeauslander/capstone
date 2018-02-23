Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

# knock gem
  post 'user_token' => 'user_token#create'

# user routes
  get '/users' => 'users#index'
  post '/users' => 'users#create'
  get '/users/:id' => 'users#show'
  patch '/users/:id' => 'users#update'
  patch '/users/:id' => 'users#destroy'

# games routes
  get '/games' => 'games#index'
  post '/games' => 'games#create'
  get '/games/:id' => 'games#show'
  patch '/games/:id' => 'games#update'
  delete '/games/:id' => 'games#destroy'

# images routes
  get '/images' => 'images#index'
  post '/images' => 'images#create'
  get '/images/:id' => 'images#show'
  patch '/images/:id' => 'images#update'
  delete '/images/:id' => 'images#destroy'

# tags routes
  get '/tags' => 'tags#index'
  post '/tags' => 'tags#create'
  get '/tags/:id' => 'tags#show'
  patch '/tags/:id' => 'tags#update'
  delete '/tags/:id' => 'tags#destroy'

# game_images routes
  get '/game_images' => 'game_images#index'
  post '/game_images' => 'game_images#create'
  get '/game_images/:id' => 'game_images#show'
  patch '/game_images/:id' => 'game_images#update'
  patch '/game_images/:id' => 'game_images#destroy'

# image_tags routes
  get '/image_tags' => 'image_tags#index'
  post '/image_tags' => 'image_tags#create'
  get '/image_tags/:id' => 'image_tags#show'
  patch '/image_tags/:id' => 'image_tags#update'
  patch '/image_tags/:id' => 'image_tags#destroy'


end
