class ControlarResenasController < ApplicationController
  before_action :require_admin!
  before_action :set_reporte, only: [:update]

  def index
    @reportes = Reporte
                .includes(producto_review: [:producto, :user], cliente: [])
                .pendientes
                .recientes
  end

  def update
    reporte = Reporte.find(params[:id])
    review  = reporte.producto_review
    autor   = review.user

    case params[:accion]
    when "eliminar"
      Reporte.where(producto_review_id: review.id).destroy_all
      review.destroy
      flash[:notice] = I18n.t("resenas.eliminada")

    when "banear"
      autor.update!(bloqueado: true)
      Reporte.where(producto_review_id: review.id).destroy_all
      review.destroy
      flash[:notice] = I18n.t("resenas.usuario_baneado")

    when "ignorar"
      flash[:notice] = I18n.t("resenas.reporte_ignorado")
    end

    reporte.update!(estado: "resuelto") unless params[:accion].in?(["eliminar", "banear"])
    redirect_to admin_resenas_path
  end

  private

  def set_reporte
    @reporte = Reporte.find(params[:id])
  end

  # Mismo metodo que usuarios_admin_controller
  def require_admin!
    unless current_user&.is_a?(Administrador)
      redirect_to root_path, alert: I18n.t("resenas.acceso_no_autorizado")
    end
  end
end