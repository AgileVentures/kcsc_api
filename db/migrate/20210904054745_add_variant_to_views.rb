class AddVariantToViews < ActiveRecord::Migration[6.1]
  def change
    add_column :views, :variant, :integer
  end
end
