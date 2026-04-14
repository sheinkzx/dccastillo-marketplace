class HomeController < ApplicationController
  def index
    # Si hay un vendedor logueado, cargamos sus productos
    if current_user.is_a?(Vendedor)

      #* Productos del vendedor
      @productos = Producto.where(vendedor: current_user)

      #* Compras pendientes de sus productos
      @compras_pendientes = Compra.where(vendedor: current_user, estado: "pendiente")
    end
  end

  def home
    "esto permite que la página sepa si hay alguien logueado"
    # No necesitamos lógica extra por ahora
  end
end