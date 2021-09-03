class CreateSections < ActiveRecord::Migration[6.1]
  def change
    create_table :sections do |t|
      t.references :view, null: false, foreign_key: true
      t.string :header
      t.text :description
      t.integer :variant

      t.timestamps
    end
  end
end
