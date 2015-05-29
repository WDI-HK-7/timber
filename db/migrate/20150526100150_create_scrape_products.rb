class CreateScrapeProducts < ActiveRecord::Migration
  def change
    create_table :scrape_products do |t|
      t.string :photo
      t.string :name
      t.string :price
      t.timestamps null: false
    end
  end
end
