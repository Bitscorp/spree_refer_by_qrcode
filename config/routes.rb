Spree::Core::Engine.add_routes do
  resources :users, only: [] do
    member do
      get :qr_code
    end
  end
end
