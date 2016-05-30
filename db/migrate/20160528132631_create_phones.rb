class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :number
      t.string :extension
      t.text :notes

      t.timestamps null: false
    end
    add_reference :phones, :contact, index: true, foreign_key: true
  end
end
