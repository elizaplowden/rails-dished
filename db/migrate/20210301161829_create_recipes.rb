class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :description
      t.text :instructions
      t.string :meal
      t.string :cuisine
      t.integer :serves
      t.integer :cook_time
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
