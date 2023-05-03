require "test_helper"

class Admin::PictCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_pict_comments_index_url
    assert_response :success
  end
end
