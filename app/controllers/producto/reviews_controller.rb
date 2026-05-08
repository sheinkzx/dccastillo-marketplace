class Producto::ReviewsController < ApplicationController
  def create
    @producto = Producto.find(params[:id_producto])
    # Crea la reseña
    @review = @producto.reviews.build(review_params)
    # Asigna el usuario actual como autor
    @review.user = current_user

    if @review.save
      redirect_to @producto
    else
      redirect_to @producto, alert: "Error en la reseña."
      #raise @review.errors.full_messages.inspect
    end
  end

  private

  def review_params
    params.require(:producto_review).permit(:txt, :puntaje)
  end
end
