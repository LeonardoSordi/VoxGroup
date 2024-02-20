class SetMailToAuthor < ActiveRecord::Migration[7.1]
  def up
    authors = Author.where(mailaddress:  nil)
    authors.update_all(mailaddress: "giacomo.di.stefano.95@gmail.com")
  end
end
