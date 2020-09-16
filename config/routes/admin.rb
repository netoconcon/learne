namespace :admin do
  resources :orders, only: [:index, :show]
  resources :companies do
    resources :bank_accounts
  end
  resources :products
  resources :kits
  resources :kit_products
  resources :campaigns
  resources :selling_pages

  namespace :charts do
    get "values"
  end

  resources :plans, except: [:destroy, :update] do
    get '/activate_plan', to: 'plans#activate_plan', as: :activate_plan
    get '/publish_plan', to: 'plans#publish_plan', as: :publish_plan
    get '/deactivate_plan', to: 'plans#deactivate_plan', as: :deactivate_plan
  end
  patch '/plans/:id', to: "plans#update", as: "update_plan"

end
