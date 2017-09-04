Rails.application.config.session_store :cookie_store, key: "_subdomain_session", domain: {
  production: ".ruslan-project.tk",
  development: ".lvh.me"
}.fetch(Rails.env.to_sym, :all)
