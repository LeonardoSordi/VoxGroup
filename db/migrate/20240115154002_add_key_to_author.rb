class AddKeyToAuthor < ActiveRecord::Migration[7.1]
  def change
    add_column :authors, :key, :string
  end
end
