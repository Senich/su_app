class AddReferencesToUsersAndProducts < ActiveRecord::Migration
  def change
    add_reference :products, :company, index: true, foreign_key: true
    add_reference :users, :company, index: true, foreign_key: true
  end
end
