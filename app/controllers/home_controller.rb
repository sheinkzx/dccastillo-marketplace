class HomeController < ApplicationController
  def index
  end

  def home
    "esto permite que la página sepa si hay alguien logueado"
    # No necesitamos lógica extra por ahora
  end
end
