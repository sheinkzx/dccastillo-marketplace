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
      @producto.destroy
      redirect_to root_path, notice: "Producto eliminado"
    else
      redirect_to root_path, alert: "No puedes eliminar este producto"
    end
  end

  # RU03 /productos/:id
  def show
    @producto = Producto.find(params[:id])
  end

  # RU01 /productos
  def index
    @productos = Producto.all
  end

  private

  def producto_params
    params.require(:producto).permit(:titulo, :precio, :descripcion, :marca, :stock, :fecha)
  end
end