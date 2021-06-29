class AddLanguageToInquiries < ActiveRecord::Migration[6.1]
  def change
    add_column :inquiries, :language, :string, null: false
  end
end
