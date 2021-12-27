require "test_helper"

class ShowFriendControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get show_friend_show_url
    assert_response :success
  end
end
