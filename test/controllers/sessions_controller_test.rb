# require "test_helper"

# class SessionsControllerTest < ActionDispatch::IntegrationTest
#   setup do
#     @user = User.create!(
#       nombre: "Modelo Prueba",
#       email: "modeloprueba@gmail.com",
#       password: "modeloprueba",
#       password_confirmation: "modeloprueba",
#       type: "Cliente"
#     )
#   end

#   test "should get new" do
#     get login_url
#     assert_response :success
#   end

#   test "should get create" do
#     post login_url, params: { email: @user.email, password: "modeloprueba" }
#     assert_response :redirect
#   end

#   test "should get destroy" do
#     delete logout_url
#     assert_response :redirect
#   end
# end