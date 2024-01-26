class AddLanguageToAritcle < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :language, :string
  end
end
