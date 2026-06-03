class ReportesController < ApplicationController
  before_action :require_login!

  def create
    producto = Producto.find(params[:producto_id])
    review   = producto.reviews.find(params[:review_id])

    if Reporte.exists?(producto_review: review, cliente: current_user)
      redirect_to producto_path(producto), alert: I18n.t("reportes.ya_reportado")
      return
    end

    reporte = Reporte.new(reporte_params)
    reporte.producto_review = review
    reporte.cliente         = current_user

    if reporte.save
      redirect_to producto_path(producto), notice: I18n.t("reportes.enviado")
    else
      redirect_to producto_path(producto), alert: I18n.t("reportes.motivo_invalido")
    end
  end

  private

  def reporte_params
    params.require(:reporte).permit(:motivo, :detalle)
  end

  def require_login!
    unless current_user
      redirect_to login_path, alert: I18n.t("reportes.iniciar_sesion")
    end
  end
end