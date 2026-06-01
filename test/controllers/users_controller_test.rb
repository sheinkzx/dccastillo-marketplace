 require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @cliente = Cliente.create!(
      nombre: "Modelo Prueba Cliente",
      email: "modelopruebacliente@gmail.com",
      password: "modelopruebacliente"
    )
  end  
 
  test "new muestra formulario de registro" do
    get "/productos/new"
    assert_response :success
  end
 
  test "create registra un cliente nuevo y redirige" do
    assert_difference("User.count") do
      post users_path, params: {
        user: {
          nombre: @cliente.nombre,
          email: "modelopruebac@gmail.com",
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

  test "create registra un vendedor nuevo y redirige" do
    assert_difference("User.count") do
      post users_path, params: {
        user: {
          nombre: "Nuevo Vendedor",
          email: "nuevovendedor@gmail.com",
          password: "nuevovendedor",
          type: "Vendedor"
        }
      }
    end
    assert_response :redirect
  end

  test "create no permite type inválido" do
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

  test "edit muestra formulario si hay sesión activa" do
    post login_path, params: { email: @cliente.email, password: "modelopruebacliente" }
    get "/perfil/editar"
    assert_response :success
  end

  test "update modifica el perfil con datos válidos" do
    post login_path, params: { email: @cliente.email, password: "modelopruebacliente" }
    patch "/perfil", params: {
      user: { nombre: "Nombre Actualizado" }
    }
    assert_redirected_to root_path
  end

  test "update no modifica el perfil con email inválido" do
    post login_path, params: { email: @cliente.email, password: "modelopruebacliente" }
    patch "/perfil", params: {
      user: { email: "no-es-email" }
    }
    assert_response :unprocessable_entity
  end
 
end
