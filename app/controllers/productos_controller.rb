class ProductosController < ApplicationController
  def new
    @producto = Producto.new
  end

  def create
    @producto = Producto.new(producto_params)
    @producto.vendedor_id = current_user.id

    if @producto.save
      redirect_to root_path, notice: "Producto publicado exitosamente"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @producto = Producto.find(params[:id])

    if @producto.vendedor == current_user

      if @producto.compras.any?
        redirect_to root_path, alert: "No puedes eliminar este producto porque
         ya tiene compras asociadas"
      
      else
        @producto.destroy
        redirect_to root_path, notice: "Producto eliminado"
      end
    else
      redirect_to root_path, alert: "No puedes eliminar este producto"
    end
  end

  # RU03 /productos/:id
  def show
    @producto = Producto.includes(:reviews).find(params[:id])

    #RU15: Revisa si el usuario ha comprado el producto
    if current_user
      @ha_comprado = Compra.exists?(cliente_id: current_user.id,
                                    producto_id: @producto.id)
    else
      @ha_comprado = false
    end
  end
  
  def index
    # RU04: /productos?q=Lego
    que = params[:q].to_s.strip # quita espacios (trim) el parámetro q del GET
    if que.present?
      @productos = Producto.where("LOWER(TRIM(titulo)) LIKE LOWER(?)",
                                  "%#{que}%")

    # RU01 /productos
    else
      @productos = Producto.all
    end
  end
  

  private

  def producto_params
    params.require(:producto)
          .permit(:titulo, :precio, :descripcion, :marca, :stock, :fecha)
  end
end