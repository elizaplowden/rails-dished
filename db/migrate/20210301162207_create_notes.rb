class CreateNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :notes do |t|
      t.text :description
      t.references :bookmark, null: false, foreign_key: true

      t.timestamps
    end
  end
end
