Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "tutorial#index"

  get '/:trap_id', to: redirect('/%{trap_id}/requests')
  get ":trap_id/requests", to: "request#index", as: 'requests'
  get ":trap_id/requests/:id", to: "request#show", as: 'request'

  match ":trap_id/*path", to: "request#new", via: :all
end
