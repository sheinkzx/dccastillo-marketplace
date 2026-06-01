require "test_helper"
 
class UserTest < ActiveSupport::TestCase
 
  # TESTS DE USER
 
  test "usuario valido con todos los datos correctos" do
    user = Cliente.new(
      nombre: "Modelo Prueba Cliente",
      email: "modelopruebacliente@gmail.com",
      password: "modelopruebacliente"
    )
    result = user.valid?
    assert result, "Deberia ser valido con todos los datos correctos" 
  end
 
  test "usuario no valido sin nombre" do
    user = Cliente.new(
      email: "modelopruebacliente@gmail.com",
      password: "modelopruebacliente"
    )
    result = user.valid?
    assert_not result, "No Deberia ser valido sin nombre"
  end
 
  test "usuario no valido sin email" do
    user = Cliente.new(
      nombre: "Modelo Prueba Cliente",
      password: "modelopruebacliente"
    )
    result = user.valid?
    assert_not result, "No Deberia ser valido sin email"
  end
 
  test "usuario no valido con email duplicado" do
    Cliente.create!(
      nombre: "Modelo Prueba Cliente",
      email: "modelopruebacliente@gmail.com",
      password: "modelopruebacliente"
    )
    user2 = Cliente.new(
      nombre: "Modelo Prueba Vendedor",
      email: "modelopruebacliente@gmail.com",
      password: "modelopruebavendedor"
    )
    result = user2.valid?
    assert_not result, "No Deberia permitir emails duplicados"
  end
 
  test "usuario no valido con email sin formato correcto" do
    user = Cliente.new(
      nombre: "Modelo Prueba Cliente",
      email: "esto-no-es-un-email",
      password: "modelopruebacliente"
    )
    result = user.valid?
    assert_not result, "No Deberia aceptar email sin formato valido"
  end
 
  test "usuario no valido con password menor a 6 caracteres" do
    user = Cliente.new(
      nombre: "Modelo Prueba Cliente",
      email: "modelopruebacliente@gmail.com",
      password: "abc"
    )
    result = user.valid?
    assert_not result, "No Deberia aceptar contraseña menor a 6 caracteres"
  end
 
  test "usuario valido al actualizar sin cambiar password" do
    user = Cliente.create!(
      nombre: "Modelo Prueba Cliente",
      email: "modelopruebacliente@gmail.com",
      password: "modelopruebacliente"
    )
    result = user.update(nombre: "Modelo Prueba Cliente Editado")
    assert result, "Deberia poder actualizar nombre sin tocar la contraseña"
  end
 
  # TESTS DE PRODUCTO
 
  test "producto valido con todos los datos correctos" do
    vendedor = Vendedor.create!(
      nombre: "Modelo Prueba Vendedor",
      email: "modelopruebavendedor@gmail.com",
      password: "modelopruebavendedor"
    )
    producto = Producto.new(
      titulo: "Lego Set",
      precio: 9999,
      descripcion: "Juego de bloques",
      marca: "Lego",
      estado: "Activo",
      stock: 10,
      vendedor: vendedor
    )
    assert producto.valid?, "Deberia ser valido"
  end
 
  test "producto no valido sin título" do
    vendedor = Vendedor.create!(
      nombre: "Modelo Prueba Vendedor",
      email: "modelopruebavendedor@gmail.com",
      password: "modelopruebavendedor"
    )
    producto = Producto.new(
      precio: 100,
      descripcion: "Sin título",
      marca: "MarcaTest",
      estado: "Activo",
      stock: 5,
      vendedor: vendedor
    )
    assert_not producto.valid?, "No Deberia ser valido sin título"
  end
 
  test "producto no valido sin precio" do
    vendedor = Vendedor.create!(
      nombre: "Modelo Prueba Vendedor",
      email: "modelopruebavendedor@gmail.com",
      password: "modelopruebavendedor"
    )
    producto = Producto.new(
      titulo: "Algo",
      descripcion: "Sin precio",
      marca: "MarcaTest",
      estado: "Activo",
      stock: 5,
      vendedor: vendedor
    )
    assert_not producto.valid?, "No Deberia ser valido sin precio"
  end
 
  test "producto no valido con precio igual a cero" do
    vendedor = Vendedor.create!(
      nombre: "Modelo Prueba Vendedor",
      email: "modelopruebavendedor@gmail.com",
      password: "modelopruebavendedor"
    )
    producto = Producto.new(
      titulo: "Algo",
      precio: 0,
      descripcion: "Precio cero",
      marca: "MarcaTest",
      estado: "Activo",
      stock: 5,
      vendedor: vendedor
    )
    assert producto.valid?, "Precio 0 deberia ser valido (producto gratis)"
  end
 
  test "producto no valido con precio negativo" do
    vendedor = Vendedor.create!(
      nombre: "Modelo Prueba Vendedor",
      email: "modelopruebavendedor@gmail.com",
      password: "modelopruebavendedor"
    )
    producto = Producto.new(
      titulo: "Algo",
      precio: -1,
      descripcion: "Precio negativo",
      marca: "MarcaTest",
      estado: "Activo",
      stock: 5,
      vendedor: vendedor
    )
    assert_not producto.valid?, "No Deberia aceptar precio negativo"
  end
 
  test "producto no valido sin descripcion" do
    vendedor = Vendedor.create!(
      nombre: "Modelo Prueba Vendedor",
      email: "modelopruebavendedor@gmail.com",
      password: "modelopruebavendedor"
    )
    producto = Producto.new(
      titulo: "Algo",
      precio: 100,
      marca: "MarcaTest",
      estado: "Activo",
      stock: 5,
      vendedor: vendedor
    )
    assert_not producto.valid?, "No Deberia ser valido sin descripción"
  end
 
  test "producto no valido sin stock" do
    vendedor = Vendedor.create!(
      nombre: "Modelo Prueba Vendedor",
      email: "modelopruebavendedor@gmail.com",
      password: "modelopruebavendedor"
    )
    producto = Producto.new(
      titulo: "Algo",
      precio: 100,
      descripcion: "Sin stock definido",
      marca: "MarcaTest",
      estado: "Activo",
      vendedor: vendedor
    )
    assert_not producto.valid?, "No Deberia ser valido sin stock"
  end
 
  test "producto valido con stock igual a cero" do
    vendedor = Vendedor.create!(
      nombre: "Modelo Prueba Vendedor",
      email: "modelopruebavendedor@gmail.com",
      password: "modelopruebavendedor"
    )
    producto = Producto.new(
      titulo: "Agotado",
      precio: 100,
      descripcion: "Sin unidades",
      marca: "MarcaTest",
      estado: "Agotado",
      stock: 0,
      vendedor: vendedor
    )
    assert producto.valid?, "Stock 0 Deberia ser valido (>= 0)"
  end
 
  test "producto no valido con stock negativo" do
    vendedor = Vendedor.create!(
      nombre: "Modelo Prueba Vendedor",
      email: "modelopruebavendedor@gmail.com",
      password: "modelopruebavendedor"
    )
    producto = Producto.new(
      titulo: "Algo",
      precio: 100,
      descripcion: "Stock negativo",
      marca: "MarcaTest",
      estado: "Activo",
      stock: -5,
      vendedor: vendedor
    )
    assert_not producto.valid?, "No Deberia aceptar stock negativo"
  end
 
  # TESTS DE COMPRA
 
  test "compra valida con estado pendiente" do
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
    compra = Compra.new(
      producto: producto,
      cliente: cliente,
      vendedor: vendedor,
      estado: "pendiente",
      fecha: Date.today
    )
    assert compra.valid?, "Compra pendiente Deberia ser valida"
  end
 
  test "compra valida con estado aprobado" do
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
      precio: 200,
      descripcion: "Bloques",
      marca: "Lego",
      estado: "Activo",
      stock: 3,
      vendedor: vendedor
    )
    compra = Compra.new(
      producto: producto,
      cliente: cliente,
      vendedor: vendedor,
      estado: "aprobado",
      fecha: Date.today
    )
    assert compra.valid?, "Compra aprobada Deberia ser valida"
  end
 
  test "compra no valida con estado invalido" do
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
      precio: 300,
      descripcion: "Bloques",
      marca: "Lego",
      estado: "Activo",
      stock: 2,
      vendedor: vendedor
    )
    compra = Compra.new(
      producto: producto,
      cliente: cliente,
      vendedor: vendedor,
      estado: "cancelado",
      fecha: Date.today
    )
    assert_not compra.valid?, "Estado 'cancelado' no Deberia ser valido"
  end
 
end

