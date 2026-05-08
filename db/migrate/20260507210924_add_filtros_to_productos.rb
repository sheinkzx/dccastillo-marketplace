class AddFiltrosToProductos < ActiveRecord::Migration[8.1]
  def change
    add_column :productos, :edad, :string
    add_column :productos, :categoria, :string
  end
end
