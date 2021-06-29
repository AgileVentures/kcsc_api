class RemoveStartDateFromInquiries < ActiveRecord::Migration[6.1]
  def change
    remove_column :inquiries, :start_date
  end
end
