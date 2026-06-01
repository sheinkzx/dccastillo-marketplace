class AddBloqueadoToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :bloqueado, :boolean, default: false, null: false unless column_exists?(:users, :bloqueado)
  end
end