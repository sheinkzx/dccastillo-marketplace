class ComprasController < ApplicationController
  def create
    #* Buscamos el producto que el cliente quiere comprar
    producto = Producto.find(params[:producto_id])
    if producto.stock <= 0
      redirect_to producto_path(producto), alert: I18n.t("compras.sin_stock")
      return
    end

    #* Creamos la compra con estado pendiente
    @compra = Compra.new(
      producto: producto,
      cliente: current_user,
      vendedor_id: producto.vendedor_id, #TODO: eliminar vendedor_id del modelo
      estado: "pendiente",
      fecha: Date.today
    )

    if @compra.save
      redirect_to root_path, notice: I18n.t("compras.solicitud_enviada")
    else
      redirect_to root_path, alert: I18n.t("compras.error_compra")
    end
  end

  def update
    #* El vendedor aprueba la compra
    @compra = Compra.find(params[:id])
    if @compra.vendedor == current_user
      #* ESTO ES PARA QUE EL VENDEDOR NO ACEPTE MAS DE LO QUE PUEDE DAR
      if @compra.producto.stock <= 0
        redirect_to root_path, alert: I18n.t("compras.sin_stock_aprobar")
        return
      end
      @compra.update(estado: "aprobado")
      @compra.producto.decrement!(:stock) #* el stock lo vamos reduciendo al haber sido aprobado la compra
      redirect_to root_path, notice: I18n.t("compras.aprobada")
    else
      redirect_to root_path, alert: I18n.t("compras.no_autorizado")
    end
  end
end