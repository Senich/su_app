class CreateCompaniesAndMalls < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :details

      t.timestamps null: false
    end

    create_table :malls do |t|
      t.string :name
      t.string :details
      t.string :street
      t.string :city
      t.string :building

      t.timestamps null: false
    end

    create_table :companies_malls, id: false do |t|
      t.belongs_to :company, index: true
      t.belongs_to :mall, index: true
    end
  end
end
