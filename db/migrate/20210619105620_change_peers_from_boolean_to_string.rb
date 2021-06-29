class ChangePeersFromBooleanToString < ActiveRecord::Migration[6.1]
  def change
    change_column :inquiries, :peers, :string
  end
end
