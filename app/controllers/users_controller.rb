class UsersController < ApplicationController # Hereda de ApplicationController (donde están las reglas globales)
  # ACCIÓN: Muestra el formulario vacío (Relato 9 y 11)
  def new
    # Crea una "caja vacía" de la clase User para que el formulario sepa qué campos mostrar.
    # El '@' hace que esta variable sea visible en el archivo HTML (la vista).
    @user = User.new
  end

  # ACCIÓN: Recibe los datos del formulario y los guarda
  def create
    # 1. Buscamos el tipo de usuario de forma segura
    # Intentamos obtenerlo de :user, :vendedor o :cliente (lo que venga primero)
    user_data = params[:user] || params[:vendedor] || params[:cliente]
    user_type = user_data&.[](:type)

    # 2. Lógica de Herencia STI
    @user = if ["Cliente", "Vendedor"].include?(user_type)
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

  # Priate significa que los métodos que siguen no pueden ser llamados desde fuera del controlador, solo se usan internamente.
  private

  # 4. Ajustamos los parámetros para que acepten la data de cualquier tipo
  def user_params(data)
    # Esto permite que Rails acepte los datos sin importar el nombre de la "caja"
    data.permit(:nombre, :email, :password, :type)
  end
end
