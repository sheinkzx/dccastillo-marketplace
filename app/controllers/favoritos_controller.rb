class FavoritosController < ApplicationController
  # Mostrar la lista de favoritos del cliente
  def index
    if current_user&.is_a?(Cliente)
      # Buscamos todos los favoritos del cliente, e incluimos el producto asociado
      @favoritos = current_user.favoritos.includes(:producto)
    else
      redirect_to root_path, alert: I18n.t("favoritos_ctrl.solo_clientes")
    end
  end

  def create
    @producto = Producto.find(params[:producto_id])

    # Creamos el nuevo favorito conectando al producto con el cliente actual
    @favorito = Favorito.new(producto: @producto, cliente: current_user)

    if @favorito.save
      redirect_to "/productos/#{@producto.id}", notice: I18n.t("favoritos_ctrl.guardado")
    else
      redirect_to "/productos/#{@producto.id}", alert: I18n.t("favoritos_ctrl.error_guardar")
    end
  end

  def destroy
    @producto = Producto.find(params[:producto_id])

    # Buscamos el favorito exacto de este cliente y este producto
    @favorito = Favorito.find_by(producto: @producto, cliente: current_user)

    if @favorito&.destroy
      redirect_to "/productos/#{@producto.id}", notice: I18n.t("favoritos_ctrl.eliminado")
    else
      redirect_to "/productos/#{@producto.id}", alert: I18n.t("favoritos_ctrl.error_eliminar")
    end
  end
end