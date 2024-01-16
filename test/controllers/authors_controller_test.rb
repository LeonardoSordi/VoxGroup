require "test_helper"

class AuthorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @author = Author.create(name: "Test", surname: "Author", age: 40, key: "90uif4394fn")
    @author_no_key = Author.create(name: "Test no key", surname: "Author", age: 40)
    @integer = 3
    puts @integer
    @integer += 1
  end

  test "index key is not present" do
    get authors_url, as: :json
    assert_response :forbidden
  end

  test "index key is wrong" do
    get authors_url, params: {key: "chiave12345678"}, as: :json
    assert_response :forbidden
  end

  test "index key is ok" do
    get authors_url, params: {key: "chiave0000"}, as: :json
    assert_response :success
  end


  test "should create author" do
    assert_difference("Author.count") do
      post authors_url, params: { author: { name: "antonio", surname: "rossi", age: 35 } }, as: :json
    end

    assert_response :success
  end

  test "show author key is not present" do
    get author_url(@author), as: :json
    assert_response :forbidden
  end


  test "show author key is wrong" do
    get author_url(@author), params: {key: "chiave12345"}, as: :json
    assert_response :forbidden
  end


  test "show author key is ok" do
    get author_url(@author),  params: {key: "chiave0000"}, as: :json
    assert_response :success
  end



  # Non esistono i file edit.json.jbuilder e _form.json.jbuilder che creano il file JSON per la risposta alla chiamata
  # Di conseguenza il test fallisce se si imposta as: :json come risposta
  # Inoltre la funzione edit del controller è vuota
  # Cancellare il test?
  test "should get edit" do
    get edit_author_url(@author), as: :json

    assert_response :success
  end

  #UPDATE
  test "should update author" do
    patch author_url(@author), params: { author: { age: 36  } }, as: :json
    @author.reload
    puts @author.inspect
    assert_response :success
    assert @author.age == 36
  end

  #UPDATE
  test "update author name having right key"  do
    new_name = "new name"
    patch author_url(@author), params: { author: { name: new_name, key: @author.key  } }, as: :json
    @author.reload
    assert_equal @author.name, new_name
  end

  #UPDATE
  test "update author name having wrong key"  do
    new_name = "new name"
    patch author_url(@author), params: { author: { name: new_name, key: "wrongkey666"  } }, as: :json
    @author.reload
    assert_response :bad_request
  end

  #UPDATE
  test "update author name not having key"  do
    new_name = "new name"
    patch author_url(@author), params: { author: { name: new_name } }, as: :json
    @author.reload
    assert_response :bad_request
  end

  #DESTROY
  test "should destroy author" do
    assert_difference("Author.count", -1) do
      delete author_url(@author), as: :json
    end

    assert :success
  end
end
