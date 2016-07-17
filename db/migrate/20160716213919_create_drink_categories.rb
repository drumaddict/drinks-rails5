class CreateDrinkCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :drink_categories do |t|
      t.string :name
      t.boolean :has_sugar, default: false
      t.boolean :has_milk, default: false
      t.integer :role, default: 0
      t.timestamps
    end
  end
end
