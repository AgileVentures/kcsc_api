class CreateCards < ActiveRecord::Migration[6.1]
  def change
    create_table :cards do |t|
      t.string :organization
      t.text :description
      t.boolean :published
      t.string :web
      t.string :facebook
      t.string :twitter
      t.references :section, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
