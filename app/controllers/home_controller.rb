class HomeController < ApplicationController
  def index
    # Si hay un vendedor logueado, cargamos sus productos
    if current_user.is_a?(Vendedor)
      @productos = Producto.where(vendedor: current_user)
    end
  end

  def home
    "esto permite que la página sepa si hay alguien logueado"
    # No necesitamos lógica extra por ahora
  end
end