Rails.application.routes.draw do
  resource :company_registration, only: %i[new create]

  constraints(Subdomains::Base) do
    devise_for :users, controllers: { registrations: "users/registrations" }
    resources :posts do
      resource :rating, only: %i[create]
    end
    root "posts#index"
  end

  root "company_registrations#new"
end
