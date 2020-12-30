resources :orders, only: [:create]
resources :campaigns, only: [:show], path: "campanha"
get "thanks", to: "orders#thanks"
post "orders/:id/postback/", to: "orders#postback"
