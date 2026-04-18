class CreateOrders < ActiveRecord::Migration[8.1]
  def change
    create_table :orders do |t|
      t.integer :total, default: 0
      t.references :user, foreign_key: true

      t.string :billing_name
      t.string :billing_address

      t.string :shipping_name
      t.string :shipping_address
      
      t.timestamps
    end
  end
end
