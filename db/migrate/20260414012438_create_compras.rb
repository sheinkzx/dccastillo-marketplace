class CreateCompras < ActiveRecord::Migration[8.1]
  def change
    create_table :compras do |t|
      t.references :producto, null: false, foreign_key: true
      t.references :cliente, null: false, foreign_key: { to_table: :users } #* apuntamos hacia aca la tabla las llaves foraneas ya que solo tenemos la tabla users
      t.references :vendedor, null: false, foreign_key: { to_table: :users }
      t.string :estado, default: "pendiente"
      t.date :fecha
      t.timestamps
    end
  end
end