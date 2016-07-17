class CreateDrinks < ActiveRecord::Migration[5.0]

  def change
    create_table :drinks do |t|
      t.references :drink_category, index: true, foreign_key: true
      t.string :name
      t.timestamps
    end
  end
end
