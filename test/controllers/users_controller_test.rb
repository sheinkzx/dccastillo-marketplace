 require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
 
  test "new muestra formulario de registro" do
    get "/productos/new"
    assert_response :success
  end
 
  test "create registra un cliente nuevo y redirige" do
    assert_difference("User.count") do
      post users_path, params: {
        user: {
          nombre: "Modelo Prueba Cliente",
          email: "modelopruebacliente@gmail.com",
          password: "modelopruebacliente",
          type: "Cliente"
        }
      }
    end
    assert_response :redirect
  end
 
  test "create no guarda usuario con datos inválidos" do
    assert_no_difference("User.count") do
      post users_path, params: {
        user: {
          nombre: "",
          email: "no-es-email",
          password: "abc",
          type: "Cliente"
        }
      }
    end
  end
  
  test "edit redirige al login si no hay sesión activa" do
    get "/perfil/editar"
    assert_redirected_to "/login"
  end
 
end
