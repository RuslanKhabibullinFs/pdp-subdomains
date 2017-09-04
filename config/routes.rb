Rails.application.routes.draw do
  resource :company_registration, only: %i[new create]

  constraints(Subdomains::Base) do
    devise_for :users, controllers: { registrations: "users/registrations" }
    resources :posts
    root "posts#index"
  end

  root "company_registrations#new"
end
