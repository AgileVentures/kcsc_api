class CreateCta < ActiveRecord::Migration[6.1]
  def change
    create_table :cta do |t|
      t.string :text
      t.string :link
      t.references :section, null: false, foreign_key: true

      t.timestamps
    end
  end
end
