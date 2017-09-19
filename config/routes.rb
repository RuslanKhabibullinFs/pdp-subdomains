Rails.application.routes.draw do
  resource :company_registration, only: %i[new create]

  constraints(SubdomainConstraint) do
    devise_for :users, controllers: { registrations: "users/registrations" }
    resources :posts do
      resource :rating, only: %i[create]
    end
    resources :users, only: %i[index] do
      resources :posts, only: %i[index], module: :users
    end
    root "posts#index"
  end

  root "company_registrations#new"
end
