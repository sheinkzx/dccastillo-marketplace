def change
  add_column :users, :bloqueado, :boolean, default: false, null: false unless column_exists?(:users, :bloqueado)
end