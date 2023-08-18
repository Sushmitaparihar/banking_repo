class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :amount
      t.integer :pin

      t.timestamps
    end
  end
end
