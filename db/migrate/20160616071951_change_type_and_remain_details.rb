class ChangeTypeAndRemainDetails < ActiveRecord::Migration
  def up
    change_column :companies, :details, :text
    change_column :malls, :details, :text
    change_column :contacts, :details, :text
    rename_column :companies, :details, :about
    rename_column :malls, :details, :about
  end
  
  def down
    change_column :companies, :details, :string
    change_column :malls, :details, :string
    change_column :contacts, :details, :string
    rename_column :companies, :about, :details
    rename_column :malls, :about, :details
  end
end
