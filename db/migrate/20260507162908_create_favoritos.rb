# RU 25 crear tabla favoritos intermedia entre productos y clientes (cliente es usuario por STI)
 
class CreateFavoritos < ActiveRecord::Migration[8.1]
  def change
    create_table :favoritos do |t|
      t.references :producto, null: false, foreign_key: true
      # Le indicamos que el cliente vive en la tabla :users
      t.references :cliente, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end