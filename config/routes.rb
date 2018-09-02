Rails.application.routes.draw do
  root 'room_users#new'

  resources :rooms, only: %i[show], param: :slug do
    get 'join', on: :member
    post 'join_room', on: :member
  end

  resources :room_users, only: %i[new create]
end
