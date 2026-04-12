class UsersController < ApplicationController # Hereda de ApplicationController (donde están las reglas globales)
  # ACCIÓN: Muestra el formulario vacío (Relato 9 y 11)
  def new
    # Crea una "caja vacía" de la clase User para que el formulario sepa qué campos mostrar.
    # El '@' hace que esta variable sea visible en el archivo HTML (la vista).
    @user = User.new
  end

  # ACCIÓN: Recibe los datos del formulario y los guarda
  def create
    # 1. Extraemos el 'type' que el usuario eligió en el formulario (Cliente o Vendedor)
    user_type = params[:user][:type]

    # 2. Lógica de Herencia STI:
    # .constantize convierte el texto "Vendedor" en la Clase Vendedor de Ruby.
    @user = if ["Cliente", "Vendedor"].include?(user_type)
      user_type.constantize.new(user_params) # Crea un Vendedor.new(...) o Cliente.new(...)
    else
      Cliente.new(user_params) # Si alguien intenta hackear el tipo, por defecto es Cliente
    end

    # 3. Intento de guardado
    if @user.save
      # Guarda el ID en la sesión del navegador para que el sistema "te reconozca"
      session[:user_id] = @user.id
      # Te envía a la página principal con un mensaje de éxito
      redirect_to root_path, notice: "¡Registro exitoso como #{@user.type}!"
    else
      # Si falla (ej: el email ya existe), vuelve a mostrar el formulario ('new')
      # El status 422 (unprocessable_entity) es un estándar web para errores de formulario
      render :new, status: :unprocessable_entity
    end
  end

  private # Todo lo que esté debajo de aquí solo puede ser usado dentro de este archivo

  # SEGURIDAD (Strong Parameters):
  # Por seguridad, Rails obliga a declarar qué campos permitimos que el usuario nos mande.
  # Si un hacker intenta mandar 'admin: true', Rails lo ignorará porque no está en esta lista.
  def user_params
    params.require(:user).permit(:nombre, :email, :password, :password_confirmation, :type)
  end
end
