class CreateLineItems < ActiveRecord::Migration[5.0]
  def change
    create_table :line_items do |t|
      t.references :order, index: true, foreign_key: true
      t.references :drink, index: true, foreign_key: true
      t.references :drink_category, index: true, foreign_key: true
      t.integer :sugar, default: 0
      t.integer :milk, default: 0
      t.integer :quantity, default: 0
      t.timestamps
    end
  end
end
