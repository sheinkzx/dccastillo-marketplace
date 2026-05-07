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
    # Partimos con todos los productos que están Activos (Visto en RU14)
    @productos = Producto.where(estado: "Activo")

    # RU04: /productos?q=Lego
    que = params[:q].to_s.strip
    if que.present?
      @productos = @productos.where("LOWER(TRIM(titulo)) LIKE LOWER(?)", "%#{que}%")
    end

    # Filtro por Precio (Escenario 2)
    if params[:precio_max].present?
      @productos = @productos.where("precio <= ?", params[:precio_max].to_f)
    end

    # Filtro por Marca (Escenario 2)
    if params[:marca].present?
      @productos = @productos.where("LOWER(marca) LIKE ?", "%#{params[:marca].downcase.strip}%")
    end

    # Filtro por Edad (Escenario 1)
    if params[:edad_cliente].present?
      edad = params[:edad_cliente].to_i
      @productos = @productos.where("edad_minima <= ? AND edad_maxima >= ?", edad, edad)
    end

    # Filtro por Categorías (Escenario 3)
    if params[:categorias].present?
      @productos = @productos.where(categoria: params[:categorias])
    end
  end

  private

  def producto_params
    # Agregamos edad_minima, edad_maxima y categoria a los permitidos (RU05)
    params.require(:producto).permit(:titulo, :precio, :descripcion, :marca, :stock, :fecha, :estado, :edad_minima, :edad_maxima, :categoria)
  end
end