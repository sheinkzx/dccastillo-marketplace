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

  # Rutas de productos (HU13 y HU15)
  get  "productos/new", to: "productos#new"
  post "productos", to: "productos#create"
  delete "productos/:id", to: "productos#destroy"
  get "productos/:id", to: "productos#show" #HU03
  get "productos", to: "productos#index" #HU01

  # Rutas de favoritos (RU 25)
  post "productos/:producto_id/favorito", to: "favoritos#create"
  delete "productos/:producto_id/favorito", to: "favoritos#destroy"
  get "mis_favoritos", to: "favoritos#index"

  # Rutas de compras (HU17)
  post "compras", to: "compras#create"
  patch "compras/:id", to: "compras#update"

end
