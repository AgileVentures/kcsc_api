class AddOrderToSection < ActiveRecord::Migration[6.1]
  def change
    add_column :sections, :order, :float, null: false, default: 0
  end
end
