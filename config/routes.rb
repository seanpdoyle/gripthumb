Rails.application.routes.draw do
  resources :identifications, only: [:new, :create]
  resources :parts, only: [:index]

  root to: redirect("/identifications/new")
end
