class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  stale_when_importmap_changes
  before_action :aplicar_locale
  before_action :verificar_no_baneado

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  helper_method :current_user

  def set_locale
    session[:locale] = params[:locale] if params[:locale].present?
    I18n.locale = session[:locale] || I18n.default_locale
    redirect_back fallback_location: root_path
  end

  private

  def aplicar_locale
    I18n.locale = session[:locale] || I18n.default_locale
  end

  def verificar_no_baneado
    if current_user&.bloqueado?
      session[:user_id] = nil
      redirect_to login_path, alert: I18n.t("errores.cuenta_suspendida")
    end
  end

  # Para chat (sprint 3)
  def require_login
    unless current_user
      redirect_to login_path, alert: "Debes iniciar sesión primero"
    end
  end
end