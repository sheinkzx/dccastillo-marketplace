Rails.application.routes.draw do
  # Esto viene del controlador de usuarios (registro)
  get "signup", to: "users#new" # Ruta para mostrar el formulario de registro
  post "users", to: "users#create" # Ruta para procesar el formulario de registro

  # Del controlador de sesiones (login/logout)
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  root "users#new" # "root" es quien define donde comienza la paguina cuando el usuario entra a la URL base
  # (localhost:3000) y lo redirige a la acción new del controlador users, que es donde se muestra el formulario de registro.
  get "up" => "rails/health#show", :as => :rails_health_check
end
