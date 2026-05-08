class AddEstadoToProductos < ActiveRecord::Migration[8.1]
  def change
    # Añadimos la columna estado del producto 
    # con el valor "Activo" por defecto para los productos nuevos
    add_column :productos, :estado, :string, default: "Activo"
  end
end
