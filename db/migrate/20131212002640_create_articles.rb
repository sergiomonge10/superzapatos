class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.integer :total_in_shelf
      t.integer :total_in_vault
      t.belongs_to :store, index: true

      t.timestamps
    end
  end
end
