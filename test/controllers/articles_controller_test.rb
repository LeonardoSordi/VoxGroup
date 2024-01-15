require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @author = Author.create(name: "Test No Key", surname: "Author", age: 40)
  end

  test "author must have key to get articles index" do

    get articles_url

    assert_response :success

  end

end
