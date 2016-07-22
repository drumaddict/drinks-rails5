class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :status, default: 0
      t.boolean :favorite, default: false
      t.boolean :reoccuring, default: false
      t.text :comments
      t.text :days, array:true, default: []
      t.integer :hour
      t.timestamps
    end
 end
end
