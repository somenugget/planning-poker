Rails.application.routes.draw do
  root 'room_users#new'

  resources :rooms, only: %i[show], param: :slug
  resources :room_users, only: %i[new create]
end
