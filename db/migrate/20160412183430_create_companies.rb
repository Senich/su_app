class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name

      t.timestamps null: false
    end

    create_table :addresses do |t|
      t.string :name
      t.string :city
      t.string :street
      t.string :building

      t.timestamps null: false
    end

    create_table :sections do |t|
      t.belongs_to :company, index: true
      t.belongs_to :address, index: true

      t.text :location

      t.timestamps null: false
    end
  end
end
