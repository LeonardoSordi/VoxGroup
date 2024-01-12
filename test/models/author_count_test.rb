# frozen_string_literal: true

require 'minitest/autorun'
require 'test_helper'

class AuthorCountTest < Minitest::Test
  def setup
    # Do nothing
  end

  def teardown
    # Do nothing
  end

  def test_author_articles_count

    author = Author.create(name: "Test", surname: "Author", age: 40)
    assert author.articles_count == 0
    puts(author.inspect)
    article = Article.create(title: "testTitle", body: "test body for article", author_id: author.id, status: "public" )
    puts(article.inspect)
    assert author.articles_count == 1
    author.destroy
    article.destroy

  end
end

