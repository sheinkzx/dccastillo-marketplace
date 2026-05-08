require "test_helper"
class Producto::ReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    vendedor = Vendedor.create!(
      nombre: "Modelo Prueba Vendedor",
      email: "modelopruebavendedor@gmail.com",
      password: "modelopruebavendedor"
    )
    cliente = Cliente.create!(
      nombre: "Modelo Prueba Cliente",
      email: "modelopruebacliente@gmail.com",
      password: "modelopruebacliente"
    )
    producto = Producto.create!(
      titulo: "Lego Set",
      precio: 100,
      descripcion: "Bloques",
      marca: "Lego",
      estado: "Activo",
      stock: 5,
      vendedor: vendedor
    )
    post login_path, params: { email: cliente.email, password: "modelopruebacliente" }
    post producto_reviews_path(producto_id: producto.id), params: {
      producto_review: { puntaje: 5, txt: "saaa" }
    }
    assert_response :redirect
  end
end