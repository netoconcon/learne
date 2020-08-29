<<<<<<< HEAD
resources :products
resources :kits
resources :kit_products
resources :orders

resources :selling_pages
resources :campaigns
resources :companies do
  resources :bank_accounts
end
=======
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
>>>>>>> 8f15b9c17c1c7f07dad90ba5488d0fe81a8e0f53
