class AddColumnsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string
    add_column :users, :profile, :text
    add_column :users, :occupation, :text
    add_column :users, :position, :text
  end
end
