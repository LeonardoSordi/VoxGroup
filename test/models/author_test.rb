require "test_helper"
require 'minitest/autorun'

class AuthorTest < ActiveSupport::TestCase

  def setup
    @author=FactoryBot.create(:author)
    @article=FactoryBot.create(:article)
  end


  test 'count' do
    author_articles_count = @author.articles_count
    Article.create(title: "testTitle 2", body: "test body for article 2", author_id: @author.id, status: "public", language: "en" )
    assert_equal author_articles_count+1, @author.articles_count
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
    assert @author.key.present?
  end

  test'check key not change on update' do
    a = Author.create(name: "Ciao", surname: "Ciao", age: 43)
    current_key = a.key.dup
    a.update(name: "Hello")

    assert_equal current_key, a.key
  end

end
