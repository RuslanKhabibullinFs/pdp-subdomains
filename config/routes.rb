Rails.application.routes.draw do
  resource :company_registration, only: %i[new create]

  constraints(Subdomains::Base) do
    devise_for :users, controllers: { registrations: "users/registrations" }
    devise_scope :user do
      root "devise/sessions#new"
    end

    resources :posts
  end

  root "company_registrations#new"
end
