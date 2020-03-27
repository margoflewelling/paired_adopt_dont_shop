Rails.application.routes.draw do
  root 'welcome#index'
  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:shelter_id/edit', to: 'shelters#edit'
  patch '/shelters/:shelter_id', to: 'shelters#update'
  delete '/shelters/:shelter_id', to: 'shelters#destroy'
  get '/shelters/:shelter_id', to: 'shelters#show'

  get '/pets', to: 'pets#index'
  get '/pets/:pet_id', to: 'pets#show'
  get '/shelters/:shelter_id/pets/new', to: 'pets#new'
  post '/shelters/:shelter_id/pets', to: 'pets#create'
  get '/pets/:pet_id/edit', to: 'pets#edit'
  patch '/pets/:pet_id', to: 'pets#update'
  delete '/pets/:pet_id', to: 'pets#destroy'

  get '/shelters/:shelter_id/pets', to: 'showpets#index'

  get '/shelters/:shelter_id/review/new', to: 'reviews#new'
  post '/shelters/:shelter_id/review/new', to: 'reviews#create'
  get '/shelters/:shelter_id/:review_id/edit', to: 'reviews#edit'
  patch '/shelters/:shelter_id/:review_id/edit', to: 'reviews#update'
  delete "/shelters/:shelter_id/:review_id", to: 'reviews#destroy'

  get '/favorite', to: "favorite#index"
  patch "/favorite/:pet_id", to: "favorite#update"
  delete "/favorite/:pet_id", to: "favorite#destroy"
  delete "favorite", to: "favorite#destroy_all"
end
