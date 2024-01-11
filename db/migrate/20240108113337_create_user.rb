class CreateUser < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.integer :age
      t.float :height

      t.timestamps
    end
  end
end
