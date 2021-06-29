class AddStatusToInquiries < ActiveRecord::Migration[6.1]
  def change
    add_column :inquiries, :inquiry_status, :integer
  end
end
