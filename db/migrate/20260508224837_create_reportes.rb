class CreateReportes < ActiveRecord::Migration[8.1]
  def change
    create_table :reportes do |t|
      t.references :producto_review, null: false, foreign_key: true
      t.references :cliente, null: false, foreign_key: { to_table: :users }
      t.string :motivo
      t.text :detalle
      t.string :estado, null: false, default: "pendiente"
      t.timestamps
    end
  end
end