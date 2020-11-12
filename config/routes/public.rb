resources :orders, only: [:new, :create]
resources :selling_pages, only: [:show]
get "thanks", to: "orders#thanks"
post "orders/:id/postback/", to: "orders#postback"
