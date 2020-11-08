Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: :json } do
    resources :users
    get '/typeahead/:name', to: 'users#typeahead'
  end
end
