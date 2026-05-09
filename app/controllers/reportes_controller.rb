class ReportesController < ApplicationController
  before_action :require_login!

  def create
    producto = Producto.find(params[:producto_id])
    review   = producto.reviews.find(params[:review_id])

    if Reporte.exists?(producto_review: review, cliente: current_user)
      redirect_to producto_path(producto), alert: "Ya reportaste esta reseña anteriormente."
      return
    end

    reporte = Reporte.new(reporte_params)
    reporte.producto_review = review
    reporte.cliente         = current_user

    if reporte.save
      redirect_to producto_path(producto), notice: "Reporte enviado. Lo revisaremos pronto."
    else
      redirect_to producto_path(producto), alert: "Debes seleccionar un motivo válido."
    end
  end

  private

  def reporte_params
    params.require(:reporte).permit(:motivo, :detalle)
  end

  def require_login!
    unless current_user
      redirect_to login_path, alert: "Debes iniciar sesión."
    end
  end
end