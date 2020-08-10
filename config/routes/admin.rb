resources :products
resources :kits
resources :kit_products

resources :selling_pages
resources :campaigns
resources :companies do
  resources :bank_accounts
end

