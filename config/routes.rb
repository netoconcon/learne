Rails.application.routes.draw do
  draw :admin
  draw :public
  draw :payment
  draw :api
  root to: 'pages#home'
  get "users", to: "pages#home"
  devise_for :users, path: '', path_names: { sign_in: 'login', 
                                               sign_out: 'logout',
                                               password: 'secret',
                                               confirmation: 'verification',
                                               unlock: 'unblock', 
                                               registration: 'register',
                                               sign_up: 'cmon_let_me_in' }
  get 'developedby', to: 'pages#developedby'
  get "/:kit_slug", to: "orders#new", as: "new_order"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
