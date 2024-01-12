require "test_helper"
require 'minitest/autorun'

class AuthorTest < ActiveSupport::TestCase

  def setup
    @author = Author.create(name: "Test", surname: "Author", age: 40)
    Article.create(title: "testTitle 1", body: "test body for article ", author_id: @author.id, status: "public" )
  end


  test 'count' do
    assert_equal 1, @author.articles_count
    Article.create(title: "testTitle 2", body: "test body for article 2", author_id: @author.id, status: "public" )
    assert_equal 2, @author.articles_count
  end

  test 'clean_all_my_articles' do
    @author.clean_all_my_articles

    assert_equal 0, @author.articles_count
  end

end
