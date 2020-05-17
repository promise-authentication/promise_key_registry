Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'application#index'

  resources :api do
    resources :key_pairs, constraints: { id: /.+\.json/ }, only: [:show, :create]
  end
end
