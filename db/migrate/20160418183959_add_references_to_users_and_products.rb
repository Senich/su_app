class AddReferencesToUsersAndProducts < ActiveRecord::Migration
  def change
    add_reference :products, :company, index: true
    add_reference :users, :company, index: true
  end
end
