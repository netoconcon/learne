resources :catalogs, only: [:index]
resources :financials, only: [:index]
resources :settings, only: [:index]
resources :products
resources :kits
resources :companies do
  resources :bank_accounts
end
