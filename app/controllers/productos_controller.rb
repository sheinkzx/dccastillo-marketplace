class ProductosController < ApplicationController
  def new
    @producto = Producto.new
  end

  def create
    @producto = Producto.new(producto_params)
    @producto.vendedor = current_user

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
        redirect_to root_path, alert: "No puedes eliminar este producto porque ya tiene compras asociadas"
      
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
    @producto = Producto.find(params[:id])
    if @producto.stock <= 0
      redirect_to productos_path, alert: "Este producto no está disponible" #* Esto es por si se accede directamente al link para ver si el producto no tiene stock desde la perspectiva del usuario
    end
  end
  
  def index
    # RU04: /productos?q=Lego
    que = params[:q].to_s.strip # quita espacios (trim) el parámetro q del GET
    if que.present?
      @productos = Producto.where("LOWER(TRIM(titulo)) LIKE LOWER(?)", "%#{que}%")

    # RU01 /productos
    else
      @productos = Producto.where("stock > 0")
    end
  end


  

  private

  def producto_params
    params.require(:producto).permit(:titulo, :precio, :descripcion, :marca, :stock, :fecha)
  end
end