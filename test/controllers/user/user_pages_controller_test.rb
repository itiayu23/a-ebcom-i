require "test_helper"

class User::UserPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_user_pages_index_url
    assert_response :success
  end

  test "should get show" do
    get user_user_pages_show_url
    assert_response :success
  end

  test "should get edit" do
    get user_user_pages_edit_url
    assert_response :success
  end

  test "should get check" do
    get user_user_pages_check_url
    assert_response :success
  end
end
