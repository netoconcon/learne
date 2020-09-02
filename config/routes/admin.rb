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
end
