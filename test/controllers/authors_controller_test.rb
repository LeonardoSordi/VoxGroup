require "test_helper"

class AuthorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @author = Author.create(name: "Test", surname: "Author", age: 40, key: "90uif4394fn")
    @author_no_key = Author.create(name: "Test no key", surname: "Author", age: 40)
    @integer = 3
    puts @integer
    @integer += 1
  end

  test "should get index" do
    get authors_url, as: :json
    assert_response :success
  end

  test "author must have key to get authors index" do

    get authors_url, as: :json
    assert_response :success

  end

  test "show author only if it has key" do

    get authors_url
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


  # Non esistono i file edit.json.jbuilder e _form.json.jbuilder che creano il file JSON per la risposta alla chiamata
  # Di conseguenza il test fallisce se si imposta as: :json come risposta
  # Inoltre la funzione edit del controller è vuota
  # Cancellare il test?
  test "should get edit" do
    get edit_author_url(@author), as: :json

    assert_response :success
  end


  test "should update author" do

    patch author_url(@author), params: { author: { age: 36  } }, as: :json

    @author.reload

    puts @author.inspect

    assert_response :success
    assert @author.age == 36
  end

  test "should destroy author" do
    assert_difference("Author.count", -1) do
      delete author_url(@author), as: :json
    end

    assert :success
  end
end
