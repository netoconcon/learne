resources :catalogs, only: [:index]
resources :financials, only: [:index]
resources :settings, only: [:index]
resources :products
resources :kits do 
  resources :kit_products
end
resources :selling_pages
resources :campaigns
resources :companies do
  resources :bank_accounts
end

