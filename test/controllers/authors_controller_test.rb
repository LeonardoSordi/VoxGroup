require "test_helper"

class AuthorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @author = Author.create(name: "Test", surname: "Author", age: 40)
  end

  test "should get index" do
    get authors_url, as: :json
    assert_response :success
  end

  test "should create author" do
    assert_difference("Author.count") do
      post authors_url, params: { author: { name: "antonio", surname: "rossi", age: 35 } }, as: :json
    end

    assert_response :success
  end

  test "should show author" do
    get author_url(@author), as: :json
    assert_response :success
  end

  test "should get edit" do
    get edit_author_url(@author), as: :json
    assert_response :success
  end

  test "should update author" do
    patch author_url(@author), params: { author: {  } }
    assert_redirected_to author_url(@author)
  end

  test "should destroy author" do
    assert_difference("Author.count", -1) do
      delete author_url(@author)
    end

    assert_redirected_to authors_url
  end
end
