class CreateProductos < ActiveRecord::Migration[8.1]
  def change
    create_table :productos do |t|
      t.string :titulo
      t.text :descripcion
      t.decimal :precio
      t.string :marca
      t.integer :stock
      t.date :fecha
      t.references :vendedor, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
