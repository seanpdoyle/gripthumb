Rails.application.routes.draw do
  resources :identifications, only: [:new, :create]
  resources :songs, only: [:index]

  root to: redirect("/identifications/new")
end
