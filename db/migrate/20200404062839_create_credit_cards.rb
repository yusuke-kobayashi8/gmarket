class CreateCreditCards < ActiveRecord::Migration[5.2]
  def change
    create_table :credit_cards do |t|
      #t.references :user_id, type: :integer, foreign_key: true
      #t.references :customer_id, type: :string, foreign_key: true
      #t.references :card_id, type: :string, foreign_key: true
      t.integer :user_id, null: false
      t.string :customer_id, null: false
      t.string :card_id, null: false
      
      t.timestamps
    end
  end
end
