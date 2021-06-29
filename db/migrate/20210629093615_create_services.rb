class CreateServices < ActiveRecord::Migration[6.1]
  def change
    create_table :services do |t|
      t.datetime :imported_at
      t.float :latitude
      t.float :longitude
      t.string :name
      t.text :description
      t.string :telephone
      t.string :email
      t.boolean :publish_address
      t.boolean :publish_telephone
      t.integer :charity_commission_id
      t.string :address
      t.string :postcode
      t.string :website
      t.integer :imported_id
      t.string :imported_from

      t.timestamps
    end
  end
end
