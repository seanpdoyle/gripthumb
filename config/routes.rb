Rails.application.routes.draw do
  resources :recordings, only: [:new, :create]
  resources :songs, only: [:show]

  root to: redirect("/recordings/new")
end
