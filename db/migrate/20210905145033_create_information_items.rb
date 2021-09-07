class CreateInformationItems < ActiveRecord::Migration[6.1]
  def change
    create_table :information_items do |t|
      t.string :header
      t.text :description
      t.text :link
      t.boolean :pinned
      t.boolean :publish

      t.timestamps
    end
  end
end
