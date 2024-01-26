require "test_helper"
require 'minitest/autorun'

class AuthorTest < ActiveSupport::TestCase

  def setup
    @author = Author.create(name: "Test", surname: "Author", age: 40)
    @author_no_key = Author.create(name: "Test no key", surname: "Author", age: 40)
    @article = Article.create(title: "testTitle 1", body: "test body for article", author_id: @author.id, status: "public", language: "en" )
  end


  test 'count' do
    assert_equal 1, @author.articles_count
    Article.create(title: "testTitle 2", body: "test body for article 2", author_id: @author.id, status: "public", language: "en" )
    assert_equal 2, @author.articles_count
  end

  test 'clean_all_my_articles' do
    @author.clean_all_my_articles

    assert_equal 0, @author.articles_count
  end

  test 'validate_name' do
    author2 = Author.new(name: "antonio", surname: "rossi")
    assert author2.valid?
  end

  test "key is generated on creation" do
    assert @author_no_key.key.present?
  end

  test'check key not change on update' do
    a = Author.create(name: "Ciao", surname: "Ciao", age: 43)
    current_key = a.key.dup
    a.update(name: "Hello")

    assert_equal current_key, a.key
  end

end
