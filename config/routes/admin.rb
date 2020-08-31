resources :selling_pages
resources :campaigns

namespace :admin do
  resources :orders, only: [:index, :show]
  resources :companies do
    resources :bank_accounts
  end
  resources :products
  resources :kits
  resources :kit_products
end
