Rails.application.routes.draw do
  mount AuddProxy.new(Rails.application, backend: "https://api.audd.io/", streaming: false), at: "/audd", as: :audd

  resources :recordings, only: [:new, :create]
  resources :songs, only: [:show]
  resources :parts, only: :index

  root to: redirect("/recordings/new")
end
