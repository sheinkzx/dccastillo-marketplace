class CreateProductoReviews < ActiveRecord::Migration[8.1]
  def change
    create_table :producto_reviews do |t|
      t.string :txt
      t.integer :estadp
      t.integer :puntaje

      t.timestamps
    end
  end
end
