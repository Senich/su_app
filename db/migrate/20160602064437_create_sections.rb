class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :location

      t.timestamps null: false
    end
    add_reference :sections, :company, index: true, foreign_key: true
    add_reference :sections, :mall, index:true, foreign_key: true
  end
end
