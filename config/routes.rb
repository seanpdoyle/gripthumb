Rails.application.routes.draw do
  resources :recordings, only: [:new, :create]
  resources :parts, only: :index

  root to: redirect("/recordings/new")
end
