require "test_helper"

class AuthorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @author = Author.create(name: "Test", surname: "Author", age: 40)
    @author_no_key = Author.create(name: "Test no key", surname: "Author", age: 40)
    @integer = 3
    puts @integer
    @integer += 1
  end

  test "index key not present gives bad request" do
    get authors_url, as: :json
    assert_response :bad_request
  end


  test "index key is present shows authors" do
    get authors_url, params: {key: @author.key}, as: :json
    assert_response :success
  end


  test "should create author" do
    assert_difference("Author.count") do
      post authors_url, params: { author: { name: "antonio", surname: "rossi", age: 35 } }, as: :json
    end

    assert_response :success
  end

  test "show author key is not present gives bad request" do
    get author_url(@author), as: :json
    assert_response :bad_request
  end


  test "show author key is wrong" do
    get author_url(@author), params: {key: "chiave12345"}, as: :json
    assert_response :bad_request
  end


  test "show author right key shows author" do
    get author_url(@author),  params: {key: @author.key}, as: :json
    assert_response :success
  end

  #UPDATE
  test "update author right key updates name"  do
    new_name = "new name"
    patch author_url(@author), params: { author: { name: new_name, key: @author.key  } }, as: :json
    @author.reload
    assert_equal @author.name, new_name
  end

  #UPDATE
  test "update author wrong key gives bad request"  do
    new_name = "new name"
    patch author_url(@author), params: { author: { name: new_name, key: "wrongkey666"  } }, as: :json
    @author.reload
    assert_response :bad_request
  end

  #UPDATE
  test "update author no key param gives bad request"  do
    new_name = "new name"
    patch author_url(@author), params: { author: { name: new_name } }, as: :json
    @author.reload
    assert_response :bad_request
  end

  #DESTROY
  test "destroy author no key param returns bad request" do
    delete author_url(@author), as: :json
    assert :bad_request
  end

  #DESTROY
  test "destroy author right key param destroys author" do
    delete author_url(@author), as: :json
    assert :bad_request
  end
end
