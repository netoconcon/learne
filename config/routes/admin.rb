
resources :products
resources :kits
resources :kit_products
resources :orders

resources :selling_pages
resources :campaigns
resources :companies do
  resources :bank_accounts
end

namespace :admin do
  resources :orders, only: [:index, :show]
end
