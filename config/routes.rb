Rails.application.routes.draw do
  get '/', to: 'application#index'

  resources :content, only: [:index]
  resources :purchase, only: [:create]
end
