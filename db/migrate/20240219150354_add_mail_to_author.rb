class AddMailToAuthor < ActiveRecord::Migration[7.1]
  def change
    add_column :authors, :mailaddress, :string
  end
end
