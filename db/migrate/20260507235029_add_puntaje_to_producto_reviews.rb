class AddPuntajeToProductoReviews < ActiveRecord::Migration[8.1]
  def change
    add_column :producto_reviews, :puntaje, :integer unless column_exists?(:producto_reviews, :puntaje)
  end
end
