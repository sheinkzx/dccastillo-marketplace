class AddProductoToProductoReviews < ActiveRecord::Migration[8.1]
  def change
    add_reference :producto_reviews, :producto, null: false, foreign_key: true
  end
end
