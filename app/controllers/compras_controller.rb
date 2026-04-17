class ComprasController < ApplicationController
  def create
    #* Buscamos el producto que el cliente quiere comprar
    producto = Producto.find(params[:producto_id])

    if producto.stock <= 0
      redirect_to producto_path(producto), alert: "Este producto no tiene stock disponible."
      return
    end

    #* Creamos la compra con estado pendiente
    @compra = Compra.new(
      producto: producto,
      cliente: current_user,
      vendedor: producto.vendedor,
      estado: "pendiente",
      fecha: Date.today
    )

    if @compra.save
      redirect_to root_path, notice: "Solicitud de compra enviada, espera la aprobación del vendedor"
    else
      redirect_to root_path, alert: "No se pudo realizar la compra"
    end
  end

  def update
    #* El vendedor aprueba la compra
    @compra = Compra.find(params[:id])

    if @compra.vendedor == current_user

      #* ESTO ES PARA QUE EL VENDEDOR NO ACEPTE MAS DE LO QUE PUEDE DAR
      if @compra.producto.stock <= 0
        redirect_to root_path, alert: "No puedes aprobar esta compra, el producto ya no tiene stock."
        return
      end

      @compra.update(estado: "aprobado")
      @compra.producto.decrement!(:stock) #* el stock lo vamos reduciendo al haber sido aprobado la compra
      redirect_to root_path, notice: "Compra aprobada exitosamente"
    else
      redirect_to root_path, alert: "No puedes aprobar esta compra"
    end
  end
end