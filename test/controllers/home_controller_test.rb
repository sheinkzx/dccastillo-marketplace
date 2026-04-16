require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url           #* era home_index_url
    assert_response :success
  end
end