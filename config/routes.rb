Rails.application.routes.draw do
  root 'room_users#new'

  get '/:slug', controller: :rooms, action: :show, as: :room
  get '/:slug/join', controller: :room_users, action: :new, as: :new_join
  post '/:slug/join', controller: :room_users, action: :create, as: :join

  resources :room_users, only: %i[new create]

  namespace :api do
    resources :votes, only: [:create]
    resources :rooms, only: [:update]
  end
end
