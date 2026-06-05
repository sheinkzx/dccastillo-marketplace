class CreateConversations < ActiveRecord::Migration[8.1]
  def change
    create_table :conversations do |t|
      t.references :producto, null: false, foreign_key: true
      t.integer :cliente_id
      t.integer :vendedor_id

      t.timestamps
    end
  end
end
