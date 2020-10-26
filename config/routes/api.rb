namespace :api, defaults: { format: :json } do
  namespace :v1 do
    get 'counter', to: 'customers#counter'
  end
end
