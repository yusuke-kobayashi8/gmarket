class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string     :name
      t.integer    :price
      t.text       :detail
      t.integer    :status
      t.integer    :derivery_cost_id
      t.integer    :days_to_ship_id
      t.integer    :prefecture_id
      t.references :user,     foreign_key: true
      t.references :brand,    foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
