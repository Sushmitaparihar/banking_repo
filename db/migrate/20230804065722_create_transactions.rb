class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
  
      t.string :transaction_type
      t.integer :t_amount
      t.references :user, foreign_key: true


      t.timestamps
    end
  end
end
