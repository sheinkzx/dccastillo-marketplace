class ProductosController < ApplicationController
  def new
    @producto = Producto.new
  end

  def create
    @producto = Producto.new(producto_params)
    @producto.vendedor = current_user

    if @producto.save
      redirect_to root_path, notice: I18n.t("productos_ctrl.publicado")
    else
      render :new, status: :unprocessable_entity
    end
  end

  # HU14 Muestra el formulario de edición (GET /productos/:id/edit)
  def edit
    @producto = Producto.find(params[:id])
    # si el usuario no es el dueño, lo devolvemos al inicio
    unless @producto.vendedor == current_user
      redirect_to root_path, alert: I18n.t("productos_ctrl.sin_permiso_editar")
    end
  end

  # HU14 Guarda los cambios en la base de datos (PATCH /productos/:id)
  def update
    @producto = Producto.find(params[:id])
    # Doble validación de seguridad
    if @producto.vendedor == current_user
      if @producto.update(producto_params)
        redirect_to root_path, notice: I18n.t("productos_ctrl.actualizado", titulo: @producto.titulo)
      else
        render :edit, status: :unprocessable_entity
      end
    else
      redirect_to root_path, alert: I18n.t("productos_ctrl.no_editar")
    end
  end

  def destroy
    @producto = Producto.find(params[:id])
    if @producto.vendedor == current_user
      # Soft delete: en vez de borrar físicamente, ocultamos el producto
      # Esto evita errores de foreign key con conversations, compras, etc.
      @producto.update(visible: false)
      redirect_to root_path, notice: I18n.t("productos_ctrl.eliminado")
    else
      redirect_to root_path, alert: I18n.t("productos_ctrl.no_eliminar")
    end
  end

  # RU03 /productos/:id
  def show
    # Solo mostrar productos visibles
    @producto = Producto.visibles.find(params[:id])
    if @producto.stock <= 0
      # Esto es por si se accede directamente al link para ver si el producto no tiene stock desde la perspectiva del usuario
      redirect_to productos_path, alert: I18n.t("productos_ctrl.no_disponible")
      return
    end
    @producto = Producto.visibles.includes(:reviews).find(params[:id])
    # RU15: Revisa si el usuario ha comprado el producto
    if current_user
      @ha_comprado = Compra.exists?(cliente_id: current_user.id,
                                    producto_id: @producto.id)
    else
      @ha_comprado = false
    end
  end

  def index
    # Partimos con todos los productos que están Activos (Visto en RU14) Y QUE NO ESTEN BLOQUEADOS
    # También filtramos los productos no visibles (soft delete)
    @productos = Producto.visibles.where(estado: "Activo").joins(:vendedor).where(users: { bloqueado: false })

    # RU04: /productos?q=Lego
    que = params[:q].to_s.strip
    if que.present?
      @productos = Producto.visibles.where("LOWER(TRIM(titulo)) LIKE LOWER(?)", "%#{que}%")
    else
      # RU01 /productos
      @productos = @productos.where("stock > 0")
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
    params.require(:producto).permit(:titulo, :precio, :descripcion, :marca, :stock, :fecha, :estado, :edad_minima, :edad_maxima,
                                     :categoria)
  end
end