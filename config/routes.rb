Rails.application.routes.draw do
  # Esto viene del controlador de usuarios (registro)
  get "signup", to: "users#new" # Ruta para mostrar el formulario de registro
  post "users", to: "users#create" # Ruta para procesar el formulario de registro

  # Del controlador de sesiones (login/logout)
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  root "home#index" # Ruta para la página de inicio (home)
  get "up" => "rails/health#show", :as => :rails_health_check
end
