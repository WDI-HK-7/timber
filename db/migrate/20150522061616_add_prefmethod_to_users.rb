class AddPrefmethodToUsers < ActiveRecord::Migration
  def change
    add_column :users, :prefmethod, :string
  end
end
