class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.references :company, index: true, foreign_key: true
      t.string :name
      t.string :email
      t.string :password_digest
      t.integer :role, default: 0
      t.timestamps
    end
  end
end
