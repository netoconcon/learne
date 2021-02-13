Rails.application.routes.draw do
  draw :admin
  draw :public
  draw :payment
  draw :api
  devise_for :users
  root to: 'pages#home'
  get "users", to: "pages#home"
  get 'developedby', to: 'pages#developedby'
  get "/:kit_slug", to: "orders#new", as: "new_order"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
