class AddVisibleToProductos < ActiveRecord::Migration[8.1]
  def change
    add_column :productos, :visible, :boolean, default: true, null: false
  end
end
