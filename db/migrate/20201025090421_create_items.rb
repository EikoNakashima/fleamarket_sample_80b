class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name,null: false|
      t.text :text,null: false|
      t.integer :price,null: false|
      t.string :shipment_sorce_id,null: false|
      t.string :condition_id,null: false|
      t.integer :brand_id,foreign_key: true|
      t.integer :category_id,foreign_key: true|
      t.integer :cost_id,foreign_key: true|
      t.integer :days_to_ship_id,foreign_key: true|
      t.integer :seller_id,null: false, foreign_key: true|
      t.integer :buyer_id,foreign_key: true|
      t.timestamps
    end
  end
end
