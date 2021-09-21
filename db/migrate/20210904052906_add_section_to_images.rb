class AddSectionToImages < ActiveRecord::Migration[6.1]
  def change
    add_reference :images, :section, null: true, foreign_key: true
  end
end
