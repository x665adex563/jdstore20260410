class AddIsPaidToOrder < ActiveRecord::Migration[8.1]
  def change
    add_column :orders, :is_paid, :boolean, default: false, null: false
  end
end
