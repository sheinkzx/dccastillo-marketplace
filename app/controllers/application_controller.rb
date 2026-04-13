class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  stale_when_importmap_changes

  # Método disponible en todos los controladores
  # Busca al usuario logueado usando el id guardado en la sesión
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Lo hacemos disponible también en las vistas
  helper_method :current_user
end