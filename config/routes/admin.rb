resources :catalogs, only: [:index]
resources :financials, only: [:index]
resources :settings, only: [:index]
resources :companies do
  resources :bank_accounts
end
