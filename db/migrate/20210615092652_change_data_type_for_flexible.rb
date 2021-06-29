class ChangeDataTypeForFlexible < ActiveRecord::Migration[6.1]
  def change
    change_column :inquiries, :flexible, 'integer USING CAST(flexible AS integer)'
  end
end
