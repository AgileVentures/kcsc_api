class AddStartDateToInquiry < ActiveRecord::Migration[6.1]
  def change
    add_column :inquiries, :start_date, :integer
  end
end
