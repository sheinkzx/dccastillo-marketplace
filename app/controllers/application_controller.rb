class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  stale_when_importmap_changes
  before_action :verificar_no_baneado

  # Método disponible en todos los controladores
  # Busca al usuario logueado usando el id guardado en la sesión
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Lo hacemos disponible también en las vistas
  helper_method :current_user

  private

  def verificar_no_baneado
    if current_user&.bloqueado?
      session[:user_id] = nil
      redirect_to login_path, alert: "Tu cuenta ha sido suspendida. Contacta al administrador."
    end
  end

  # Para chat (sprint 3)
  def require_login
    unless current_user
      redirect_to login_path, alert: "Debes iniciar sesión primero"
    end
  end
end