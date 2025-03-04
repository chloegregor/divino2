require "test_helper"

class BoxEchangesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get box_echanges_new_url
    assert_response :success
  end
end
