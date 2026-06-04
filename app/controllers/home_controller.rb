class HomeController < ApplicationController
  def index
    # Si hay un vendedor logueado, cargamos sus productos
    if current_user.is_a?(Vendedor)
      @productos = Producto.visibles.where(vendedor_id: current_user)
      #* Compras pendientes de sus productos
      @compras_pendientes = Compra.where(vendedor_id: current_user, estado: "pendiente")
    end
    if current_user&.is_a?(Cliente)
      @compras = Compra.where(cliente: current_user).includes(:producto)
    end
  end
 
  def home
    "esto permite que la página sepa si hay alguien logueado"
    # No necesitamos lógica extra por ahora
  end
end
