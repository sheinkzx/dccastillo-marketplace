class Producto::ReviewsController < ApplicationController
  def create
    @producto = Producto.find(params[:producto_id])
    @review = @producto.reviews.build(review_params)
    @review.user = current_user
    if @review.save
      redirect_to @producto
    else
      redirect_to @producto, alert: "Error en la reseña."
    end
  end

  private

  def review_params
    params.require(:producto_review).permit(:txt, :puntaje)
  end
end