class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :products, :product_category, :category
  end
end
