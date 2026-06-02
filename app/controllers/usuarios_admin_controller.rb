class UsuariosAdminController < ApplicationController
  #*/ before_action = filtro que corre ANTES de cada ACCION del controlador
  # require_admin! se ejecuta en TODAS las acciones: si no eres admin, te echa
  before_action :require_admin!
  # set_usuario se ejecuta SOLO antes de edit y update
  # porque son las únicas acciones que necesitan saber qué usuario editar
  before_action :set_usuario, only: [:edit, :update, :ban, :unban]

  # ACCION index: muestra el panel con la lista de todos los usuarios
  def index
    # User.where.not(id: current_user.id) = trae TODOS los usuarios de la BD
    # excepto el administrador que está logueado ahora mismo
    # current_user = el admin que está navegando (viene de application_controller)
    @usuarios = User.where.not(id: current_user.id)
  end

  # ACCION edit: solo muestra el formulario con los datos del usuario a editar
  # No necesita lógica extra porque set_usuario ya preparó @usuario arriba
  def edit
  end

  # ACCION update: se ejecuta cuando el admin apreta "Guardar cambios" en el formulario
  def update
    # usuario_params = los datos que vienen del formulario (nombre, email, foto, password)
    # los guardamos en datos_a_guardar para poder revisarlos antes de tocar la BD
    datos_a_guardar = usuario_params
    # Si el campo password llegó vacío, significa que el admin NO quiere cambiar la clave
    # entonces lo eliminamos de datos_a_guardar para no borrar la contraseña actual
    # Si llegó con valor, BCrypt lo encripta automáticamente y la clave anterior queda invalidada
    datos_a_guardar = datos_a_guardar.except(:password) if datos_a_guardar[:password].blank?
    # Intentamos guardar los cambios en la base de datos
    if @usuario.update(datos_a_guardar)
      # Exito: volvemos al panel con un mensaje de confirmación
      # @usuario.nombre muestra el nombre del usuario que se edito
      redirect_to admin_usuarios_path, notice: I18n.t("usuarios_admin.actualizado", nombre: @usuario.nombre)
    else
      # Error de validación (ej: email inválido): volvemos al formulario mostrando los errores
      render :edit, status: :unprocessable_entity
    end
  end

  def ban
    @usuario.update!(bloqueado: true)
    redirect_to admin_usuarios_path, notice: I18n.t("usuarios_admin.baneado", nombre: @usuario.nombre)
  end

  def unban
    @usuario.update!(bloqueado: false)
    redirect_to admin_usuarios_path, notice: I18n.t("usuarios_admin.desbaneado", nombre: @usuario.nombre)
  end

  private

  #* Busca en la BD al usuario que el admin quiere editar
  # El resultado se guarda en @usuario para que edit y update lo puedan usar
  def set_usuario
    @usuario = User.find(params[:id])
    #* Seguridad extra: si el admin intenta editarse a sí mismo desde este panel, lo bloqueamos
    # Para editarse a sí mismo existe la ruta normal /perfil/editar
    if @usuario == current_user
      redirect_to admin_usuarios_path, alert: I18n.t("usuarios_admin.no_editarse")
    end
  end

  # Define exactamente qué campos del formulario pueden llegar al controlador
  # Esto es una medida de seguridad de Rails llamada Strong Parameters
  # Evita que alguien envíe campos maliciosos desde el navegador (ej: hacerse admin)
  def usuario_params
    datos = params[:user] || params[:cliente] || params[:vendedor] || params[:administrador]
    datos.permit(:nombre, :email, :url_foto, :password, :type)
  end

  #* Verifica que el usuario logueado sea un Administrador antes de entrar al panel
  # current_user&.is_a?(Administrador) = pregunta si current_user es de la clase Administrador
  # El & es seguridad extra: si current_user es nil (nadie logueado) no explota
  # Si no es admin, lo manda al inicio con mensaje de error
  def require_admin!
    unless current_user&.is_a?(Administrador)
      redirect_to root_path, alert: I18n.t("usuarios_admin.acceso_no_autorizado")
    end
  end
end