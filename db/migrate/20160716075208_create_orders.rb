class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :status, default: 0
      t.boolean :cancelled, default: false
      t.boolean :favorite, default: false
      t.boolean :reoccuring, default: false
    end
  end
end
