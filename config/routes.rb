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
  post "productos", to: "productos#create", as: :productos
  delete "productos/:id", to: "productos#destroy"
  get "productos/:id", to: "productos#show", as: :producto #HU03
  get "productos", to: "productos#index" #HU01
  get "productos/:id/edit", to: "productos#edit", as: :edit_producto # Muestra el formulario HU14
  patch "productos/:id", to: "productos#update" # Procesa los datos guardados HU14

  # Rutas de favoritos (RU 25)
  post "productos/:producto_id/favorito", to: "favoritos#create"
  delete "productos/:producto_id/favorito", to: "favoritos#destroy"
  get "mis_favoritos", to: "favoritos#index"

  post '/productos/:producto_id/reviews', to: 'producto/reviews#create',
    as: :producto_reviews #HU19

  # Rutas de compras (HU17)
  post "compras", to: "compras#create"
  patch "compras/:id", to: "compras#update"

  #* Rutas de Editar perfil
  get  '/perfil/editar', to: 'users#edit',   as: :editar_perfil
  patch '/perfil',       to: 'users#update', as: :actualizar_perfil

  #* RUTAS PARA EL ADMINISTRADOR
  get  'admin/usuarios',              to: 'usuarios_admin#index',  as: :admin_usuarios
  get  'admin/usuarios/:id/editar',   to: 'usuarios_admin#edit',   as: :admin_editar_usuario
  patch 'admin/usuarios/:id',         to: 'usuarios_admin#update', as: :admin_actualizar_usuario
  patch 'admin/usuarios/:id/ban',     to: 'usuarios_admin#ban',    as: :admin_banear_usuario
  patch 'admin/usuarios/:id/unban',   to: 'usuarios_admin#unban',  as: :admin_desbanear_usuario

  #* Reporte de reseña (cliente)
  post 'productos/:producto_id/reviews/:review_id/reporte', to: 'reportes#create', as: :crear_reporte

  #* Bandeja de reseñas reportadas (admin)
  get   'admin/resenas',     to: 'controlar_resenas#index',  as: :admin_resenas
  patch 'admin/resenas/:id', to: 'controlar_resenas#update', as: :admin_resena
end