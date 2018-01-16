Rails.application.routes.draw do
  resources :user, only: %i[index show create]
end
