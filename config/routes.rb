Rails.application.routes.draw do
  get '/', to: 'application#index'

  resources :content, only: [:index]
end
