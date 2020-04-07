class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string     :postal_code,           null: false
      t.integer    :prefecture_id,         null: false
      t.string     :city,                  null: false
      t.string     :address,               null: false
      t.string     :building
      t.string     :posting_family_name,   null: false
      t.string     :posting_first_name,    null: false
      t.string     :posting_family_name_f, null: false
      t.string     :posting_first_name_f,  null: false
      t.string     :telephone
      t.references :user,                  foreign_key: true            
      t.timestamps
    end
  end
end
