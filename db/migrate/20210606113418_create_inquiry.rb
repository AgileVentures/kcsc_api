class CreateInquiry < ActiveRecord::Migration[6.1]
  def change
    create_table :inquiries do |t|
      t.integer :size
      t.integer :office_type
      t.string :company
      t.boolean :peers
      t.string :email
      t.string :start_date
      t.boolean :flexible
      t.integer :phone
      t.string :locations, array: true

      t.timestamps
    end
  end
end
