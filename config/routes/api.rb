namespace :api, defaults: { format: :json } do
  namespace :v1 do
    get 'counter', to: 'customers#counter'
	  post "/orders/:id/postback", to: "orders#postback"
    get 'installments', to: "installments#show"
  end
end
