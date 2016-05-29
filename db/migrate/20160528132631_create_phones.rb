class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.integer :number
      t.integer :extension
      t.string :notes

      t.timestamps null: false
    end
    add_reference :phones, :contact, index: true, foreign_key: true
  end
end
