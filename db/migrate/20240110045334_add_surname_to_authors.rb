class AddSurnameToAuthors < ActiveRecord::Migration[7.1]
  def change
    add_column :authors, :surname, :string
    add_column :authors, :age, :integer
  end
end
