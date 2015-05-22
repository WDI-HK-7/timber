class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes, id: false do |t|
    	t.belongs_to :user, index: true
    	t.belongs_to :post, index: true
      t.timestamps null: false
    end
  end
end
