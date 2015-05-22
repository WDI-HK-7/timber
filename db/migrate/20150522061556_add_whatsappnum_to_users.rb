class AddWhatsappnumToUsers < ActiveRecord::Migration
  def change
    add_column :users, :whatsappnum, :string
  end
end
