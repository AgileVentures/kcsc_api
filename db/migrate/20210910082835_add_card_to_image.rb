class AddCardToImage < ActiveRecord::Migration[6.1]
  def change
    add_reference :images, :card, null: true, foreign_key: true
  end
end
