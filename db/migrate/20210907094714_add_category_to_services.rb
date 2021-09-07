class AddCategoryToServices < ActiveRecord::Migration[6.1]
  def change
    add_column :services, :category, :string
    add_column :services, :category_secondary, :string
  end
end
