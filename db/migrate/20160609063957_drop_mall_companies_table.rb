class DropMallCompaniesTable < ActiveRecord::Migration
  def change
    drop_table :companies_malls
  end
end
