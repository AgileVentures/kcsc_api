class RemoveCompanyFromInquiries < ActiveRecord::Migration[6.1]
  def change
    remove_column :inquiries, :company
  end
end
