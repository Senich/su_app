class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :number
      t.string :extension
      t.string :details
      
      t.references :phoneable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
