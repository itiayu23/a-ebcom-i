require "test_helper"

class User::BookmarksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_bookmarks_index_url
    assert_response :success
  end
end
