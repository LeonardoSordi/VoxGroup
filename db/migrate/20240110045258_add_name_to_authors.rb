class AddNameToAuthors < ActiveRecord::Migration[7.1]
  def change
    add_column :authors, :name, :string
  end
end
