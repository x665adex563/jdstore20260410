class AddTokenToOrder < ActiveRecord::Migration[8.1]
  def change
    add_column :orders, :token, :string, null: false
    add_index  :orders, :token, unique: true
  end
end
