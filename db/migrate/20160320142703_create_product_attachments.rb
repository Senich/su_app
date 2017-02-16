class CreateProductAttachments < ActiveRecord::Migration
  def change
    create_table :product_attachments do |t|
      t.integer :product_id
      t.string :picture

      t.timestamps null: false
    end
  end
end
