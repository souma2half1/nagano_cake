class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|

      t.timestamps
      t.integer :order_id, null: false
      t.integer :item_id,  null: false
      t.integer :price, null: false
      t.integer :quantity, null: false
    end
  end
end
