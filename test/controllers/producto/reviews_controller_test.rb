require "test_helper"

class Producto::ReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get producto_reviews_create_url
    assert_response :success
  end
end
