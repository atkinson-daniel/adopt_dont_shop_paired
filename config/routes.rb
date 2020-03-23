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

end
