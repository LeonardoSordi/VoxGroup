class RemoveAuthorsWithNilKey < ActiveRecord::Migration[6.0]
  def up
    # Destroy records that depend on authors with nil key
    Article.where(author_id: Author.where(key: nil)).destroy_all

    # Delete authors with nil key
    Author.where(key: nil).destroy_all
  end

  def down
    # This is optional and depends on whether you want to provide a way to rollback the deletion.
    # If you want to provide a rollback, you can implement the reverse operation here.
  end
end