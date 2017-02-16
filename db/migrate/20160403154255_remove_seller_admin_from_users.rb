class RemoveSellerAdminFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :admin
    remove_column :users, :seller
  end
end
