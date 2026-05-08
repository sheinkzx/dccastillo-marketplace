class AddAgeRangesToProductos < ActiveRecord::Migration[8.1]
  def change
    add_column :productos, :edad_minima, :integer
    add_column :productos, :edad_maxima, :integer
  end
end
