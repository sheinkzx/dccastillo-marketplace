class AddUrlFotoToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :url_foto, :string
  end
end
