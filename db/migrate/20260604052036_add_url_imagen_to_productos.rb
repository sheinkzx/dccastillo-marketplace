class AddUrlImagenToProductos < ActiveRecord::Migration[8.1]
  def change
    add_column :productos, :url_imagen, :string
  end
end
