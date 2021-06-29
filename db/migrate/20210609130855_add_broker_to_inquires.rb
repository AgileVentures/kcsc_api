class AddBrokerToInquires < ActiveRecord::Migration[6.1]
  def change
    add_reference :inquiries, :broker, null: true, foreign_key: { to_table: :users }
  end
end
