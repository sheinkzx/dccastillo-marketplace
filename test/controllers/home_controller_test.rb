require "test_helper"

class ProductosControllerTest < ActionDispatch::IntegrationTest
 
  def setup
    @vendedor = Vendedor.create!(
      nombre: "Modelo Prueba Vendedor",
      email: "modelopruebavendedor@gmail.com",
      password: "modelopruebavendedor"
    )
    @cliente = Cliente.create!(
      nombre: "Modelo Prueba Cliente",
      email: "modelopruebacliente@gmail.com",
      password: "modelopruebacliente"
    )
    @producto = Producto.create!(
      titulo: "Lego Set",
      precio: 999,
      descripcion: "Juego de bloques",
      marca: "Lego",
      stock: 5,
      vendedor: @vendedor
    )
  end
 
  test "index responde con éxito" do
    get productos_path
    assert_response :success
  end
 
  test "show responde con éxito si el producto tiene stock" do
    get "/productos/#{@producto.id}"
    assert_response :success
  end
 
  test "show redirige si el producto no tiene stock" do
    @producto.update(stock: 0)
    get "/productos/#{@producto.id}"
    assert_response :redirect
  end
 
  test "new responde con éxito cuando hay sesión de vendedor" do
    post login_path, params: { email: @vendedor.email, password: "modelopruebavendedor" }
    get "/productos/new"
    assert_response :success
  end
 
  test "create aumenta el contador de productos con datos válidos" do
    post login_path, params: { email: @vendedor.email, password: "modelopruebavendedor" }
    assert_difference("Producto.count") do
      post productos_path, params: {
        producto: { titulo: "Nuevo Producto", precio: 500, descripcion: "Descripción", marca: "MarcaTest", stock: 3 }
      }
    end
    assert_response :redirect
  end
 
  test "create no guarda producto con datos inválidos" do
    post login_path, params: { email: @vendedor.email, password: "modelopruebavendedor" }
    assert_no_difference("Producto.count") do
      post productos_path, params: {
        producto: { titulo: "", precio: -1, descripcion: "", stock: -1 }
      }
    end
  end
 
  test "destroy elimina el producto si el vendedor es el dueño" do
    post login_path, params: { email: @vendedor.email, password: "modelopruebavendedor" }
    assert_difference("Producto.count", -1) do
      delete "/productos/#{@producto.id}"
    end
    assert_response :redirect
  end
 
  test "destroy no elimina producto si tiene compras asociadas" do
    Compra.create!(
      producto: @producto,
      cliente: @cliente,
      vendedor: @vendedor,
      estado: "pendiente",
      fecha: Date.today
    )
    post login_path, params: { email: @vendedor.email, password: "modelopruebavendedor" }
    assert_no_difference("Producto.count") do
      delete "/productos/#{@producto.id}"
    end
  end
 
  test "destroy no elimina producto si el usuario no es el dueño" do
    post login_path, params: { email: @cliente.email, password: "modelopruebacliente" }
    assert_no_difference("Producto.count") do
      delete "/productos/#{@producto.id}"
    end
  end
 
end
