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


# HU14 Muestra el formulario de edición (GET /productos/:id/edit) 
  def edit
    @producto = Producto.find(params[:id])
    
    # Seguridad: si el usuario no es el dueño, lo devolvemos al inicio
    unless @producto.vendedor == current_user
      redirect_to root_path, alert: "No tienes permiso para editar este producto."
    end
  end

  # HU14 Guarda los cambios en la base de datos (PATCH /productos/:id)
  def update
    @producto = Producto.find(params[:id])

    # Doble validación de seguridad
    if @producto.vendedor == current_user
      if @producto.update(producto_params)
        redirect_to root_path, notice: "Producto '#{@producto.titulo}' actualizado exitosamente."
      else
        # Si falla una validación (ej. precio en blanco), vuelve a mostrar el formulario
        render :edit, status: :unprocessable_entity
      end
    else
      redirect_to root_path, alert: "No puedes editar este producto."
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
  end
  
  def index
    # RU04: /productos?q=Lego
    que = params[:q].to_s.strip # quita espacios (trim) el parámetro q del GET
    if que.present?
      @productos = Producto.where("LOWER(TRIM(titulo)) LIKE LOWER(?)", "%#{que}%")

    # RU01 /productos
    else
      @productos = Producto.where(estado: "Activo") # HU14 solo productos activos. 
    end
  end


  

  private

  def producto_params
    params.require(:producto).permit(:titulo, :precio, :descripcion, :marca, :stock, :fecha, :estado)
  end
end