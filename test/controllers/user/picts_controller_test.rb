require "test_helper"

class User::PictsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get user_picts_new_url
    assert_response :success
  end

  test "should get show" do
    get user_picts_show_url
    assert_response :success
  end

  test "should get index" do
    get user_picts_index_url
    assert_response :success
  end

  test "should get edit" do
    get user_picts_edit_url
    assert_response :success
  end
end
