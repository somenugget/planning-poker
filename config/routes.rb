Rails.application.routes.draw do
  root 'rooms#new'

  resources :rooms, only: %i[new create show]
end
