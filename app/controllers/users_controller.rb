class UsersController < ApplicationController # Hereda de ApplicationController (donde están las reglas globales)
  # before_action se ejecuta ANTES de las acciones indicadas.
  # Aquí protegemos edit y update para que solo usuarios logueados puedan acceder (HU10)
  before_action :require_login, only: [:edit, :update]

  # ACCIÓN: Muestra el formulario vacío (Relato 9 y 11)
  def new
    # Crea una "caja vacía" de la clase User para que el formulario sepa qué campos mostrar.
    # El '@' hace que esta variable sea visible en el archivo HTML (la vista).
    @user = User.new
  end

  # ACCIÓN: Recibe los datos del formulario de registro y los guarda
  def create
    # 1. Buscamos el tipo de usuario de forma segura
    # Intentamos obtenerlo de :user, :vendedor o :cliente (lo que venga primero)
    user_data = params[:user] || params[:vendedor] || params[:cliente] || params[:administrador]
    user_type = user_data&.[](:type)
    # 2. Lógica de Herencia STI
    @user = if ["Cliente", "Vendedor", "Administrador"].include?(user_type)
              # constantize convierte el string "Cliente" o "Vendedor" en la clase real
              user_type.constantize.new(user_params(user_data))
            else
              # Si no se especifica un tipo válido, por defecto creamos un Cliente (o podríamos lanzar un error)
              Cliente.new(user_params(user_data))
            end
    # 3. Intento de guardado
    if @user.save
      # Mandamos al usuario a la página de inicio con un mensaje de éxito
      session[:user_id] = @user.id
      redirect_to root_path, notice: "¡Registro exitoso como #{@user.type}!"
    else
      # Si hay errores, mostramos el formulario de nuevo con los mensajes de error.
      flash.now[:alert] = @user.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  # ACCIÓN: Muestra el formulario de edición con los datos actuales del usuario (HU10)
  def edit
    # current_user devuelve el usuario autenticado usando session[:user_id]
    # de esta forma el usuario solo puede editar SUS propios datos
    @user = current_user
  end

  # ACCIÓN: Recibe los datos del formulario de edición y actualiza el usuario (HU10)
  def update
    @user = current_user
    # Eliminamos los campos de contraseña si vienen vacíos,
    # así el usuario no está obligado a cambiarla cada vez que edita su perfil
    # Después (busca la "caja" correcta igual que en create)
    user_data = params[:user] || params[:vendedor] || params[:cliente] || params[:administrador]
    user_data.delete(:password) if user_data[:password].blank?
    user_data.delete(:password_confirmation) if user_data[:password_confirmation].blank?
    # update() intenta modificar solo los campos permitidos por user_params_edit
    if @user.update(user_params_edit)
      # Si todo salió bien, redirigimos al inicio con mensaje de éxito
      redirect_to root_path, notice: "Perfil actualizado correctamente"
    else
      # Si hay errores (ej: email inválido), mostramos el formulario de nuevo con los mensajes
      flash.now[:alert] = @user.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  # Private significa que los métodos que siguen no pueden ser llamados desde fuera del controlador, solo se usan internamente.
  private

  # Filtra y permite solo los parámetros necesarios para el REGISTRO
  # Esto evita que alguien malintencionado envíe campos que no debe (mass assignment protection)
  def user_params(data)
    # Esto permite que Rails acepte los datos sin importar el nombre de la "caja"
    data.permit(:nombre, :email, :password, :type)
  end

  # Filtra y permite solo los parámetros necesarios para la EDICIÓN de perfil (HU10)
  # Nota: no incluimos :password aquí para no obligar al usuario a cambiarla cada vez
  # y tampoco :type para que un cliente no pueda cambiarse a Vendedor por su cuenta
  def user_params_edit
    user_data = params[:user] || params[:cliente] || params[:vendedor] || params[:administrador]
    user_data.permit(:nombre, :email, :url_foto, :password, :password_confirmation)
  end

  # Método de seguridad: redirige al login si el usuario no está autenticado
  # Es llamado automáticamente por before_action antes de edit y update
  def require_login
    unless current_user
      redirect_to login_path, alert: "Debes iniciar sesión primero"
    end
  end
  
  # ACCIÓN: Muestra el perfil público de cualquier usuario
  def show
    @user = User.find(params[:id])
    
    # Si el usuario es de tipo Vendedor, buscamos sus productos
    if @user.is_a?(Vendedor)
      # Buscamos los productos asociados a su ID
      @productos = Producto.where(user_id: @user.id)
    end
  end

end