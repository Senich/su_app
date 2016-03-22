class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :width
      t.integer :height
      t.integer :depth
      t.string :color
      t.decimal :price, precision: 8, scale: 2
      t.string :product_category 
      t.text :description

      t.timestamps null: false
    end
  end
end
