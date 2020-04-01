Rails.application.routes.draw do
  get "/", to: "welcome#index"

  get "/shelters", to: "shelters#index"
  get "/shelters/new", to: "shelters#new"
  post "/shelters", to: "shelters#add"
  get "/shelters/:id", to: "shelters#show"
  get "/shelters/:id/edit", to: "shelters#edit"
  patch "/shelters/:id", to: "shelters#update"
  delete "/shelters/:shelter_id/pets/:pet_id", to: "shelter_pets#destroy"
  delete "/shelters/:id", to: "shelters#destroy"

  get "/pets/:id", to: "pets#show"
  get "/pets", to: "pets#index"
  get "/shelters/:shelter_id/pets", to: "shelter_pets#index"
  get "/shelters/:shelter_id/pets/new", to: "pets#new"
  post "/shelters/:shelter_id/pets", to: "pets#create"
  get "/pets/:pet_id/edit", to: "pets#edit"
  patch "/pets/:pet_id", to: "pets#update"
  delete "/pets/:id", to: "pets#destroy"

  patch "/pets/:pet_id/pending", to: "pets#adoption_status_pending"
  patch "/pets/:pet_id/adoptable", to: "pets#adoption_status_adoptable"

  get "shelters/:shelter_id/reviews/new", to: "reviews#new"
  post "shelters/:shelter_id/reviews", to: "reviews#create"
  get "/shelters/:shelter_id/reviews/:review_id/edit", to: "reviews#edit"
  patch "/shelters/:shelter_id/reviews/:review_id", to: "reviews#update"
  delete "/shelters/:shelter_id/reviews/:review_id", to: "reviews#destroy"

  get "/favorites", to: "favorites#index"
  patch "/favorites/:pet_id", to: "favorites#update"
  delete "/favorites/:pet_id", to: "favorites#remove"
  delete "/favorites", to: "favorites#destroy"

  get "/applications/new", to: "applications#new"
  get "/applications/:application_id", to: "applications#show"
  get "/pets/:pet_id/applications", to: "pet_applications#index"
  post "/applications", to: "applications#create"

  resources :pet_applications, only: [:update, :destroy]
end
