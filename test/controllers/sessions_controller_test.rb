 require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
 
  def setup
    @cliente = Cliente.create!(
      nombre: "Modelo Prueba Cliente",
      email: "modelopruebacliente@gmail.com",
      password: "modelopruebacliente"
    )
  end
 
  test "login muestra formulario correctamente" do
    get login_path
    assert_response :success
  end
 
  test "login exitoso redirige al inicio" do
    post login_path, params: { email: @cliente.email, password: "modelopruebacliente" }
    assert_redirected_to root_path
  end
 
  test "login fallido muestra formulario de nuevo" do
    post login_path, params: { email: @cliente.email, password: "claveincorrecta" }
    assert_response :unprocessable_entity
  end
 
  test "logout limpia la sesión y redirige al inicio" do
    post login_path, params: { email: @cliente.email, password: "modelopruebacliente" }
    delete logout_path
    assert_redirected_to root_path
  end
 
end
