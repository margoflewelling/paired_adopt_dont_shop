Rails.application.routes.draw do
  root 'welcome#index'
  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'

  post '/shelters/:id', to: 'reviews#create'

  post '/shelters', to: 'shelters#create'
  get '/shelters/:id', to: 'shelters#show'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'

  get '/pets', to: 'pets#index'
  get '/shelters/:id/pets/new', to: 'pets#new'
  post '/shelters/:id/pets', to: 'pets#create'
  get '/pets/:id', to: 'pets#show'
  get '/pets/:id/edit', to: 'pets#edit'
  patch '/pets/:id', to: 'pets#update'
  delete '/pets/:id', to: 'pets#destroy'


  get '/shelters/:id/review/new', to: 'reviews#new'
  get '/shelters/:shelter_id/:review_id/edit', to: 'reviews#edit'
  patch '/shelters/:shelter_id/:review_id', to: 'reviews#update'

  delete "/shelters/:shelter_id/:review_id", to: 'reviews#destroy'
  get '/shelters/:id/pets', to: 'showpets#index'

end
