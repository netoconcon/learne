Rails.application.routes.draw do
  draw :admin
  draw :public
  draw :payment
  devise_for :users
  root to: 'pages#home'
  get "users", to: "pages#home"
  get "/:selling_page_url", to: "selling_pages#kit_show", as: "selling_page_public"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
