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

  test "login fallido con email inexistente" do
    post login_path, params: { email: "noexiste@gmail.com", password: "cualquiera" }
    assert_response :unprocessable_entity
  end

  test "login fallido con password vacío" do
    post login_path, params: { email: @cliente.email, password: "" }
    assert_response :unprocessable_entity
  end

  test "login fallido con email vacío" do
    post login_path, params: { email: "", password: "modelopruebacliente" }
    assert_response :unprocessable_entity
  end

  test "vendedor puede iniciar sesión correctamente" do
    vendedor = Vendedor.create!(
      nombre: "Vendedor Sesión",
      email: "vendedorsesion@gmail.com",
      password: "vendedorsesion"
    )
    post login_path, params: { email: vendedor.email, password: "vendedorsesion" }
    assert_redirected_to root_path
  end

  test "logout sin sesión activa redirige al inicio" do
    delete logout_path
    assert_redirected_to root_path
  end

  test "no se puede acceder a ruta protegida sin sesión" do
    get "/perfil/editar"
    assert_redirected_to login_path
  end
 
end
