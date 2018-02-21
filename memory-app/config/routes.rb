Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'user_token' => 'user_token#create'
  post '/users' => 'users#create'

  get '/games' => 'games#index'
  post '/games' => 'games#create'
  get '/games/:id' => 'games#show'
  patch '/games/:id' => 'games#update'
  delete '/games/:id' => 'games#destroy'

  get '/images' => 'images#index'
  post '/images' => 'images#create'
  get '/images/:id' => 'images#show'
  patch '/images/:id' => 'images#update'
  delete '/images/:id' => 'images#destroy'

  get '/tags' => 'tags#index'
  post '/tags' => 'tags#create'
  get '/tags/:id' => 'tags#show'
  patch '/tags/:id' => 'tags#update'
  delete '/tags/:id' => 'tags#destroy'

  get '/game_images' => 'game_images#index'


end
