class SessionsController < ApplicationController
  def new
    " ACCIÓN 'new': Solo sirve para mostrar el formulario de login. "
    # No necesita lógica porque Rails busca automáticamente la vista 'new.html.erb'.
  end

  def create
    # 1. Buscamos en la tabla 'users' al usuario que tenga el email escrito en el formulario.
    # params[:email] es el dato que viene de la cajita de texto del HTML.
    user = User.find_by(email: params[:email])

    # 2. El filtro de seguridad:
    # 'user' verifica que hayamos encontrado a alguien con ese email.
    # 'user.authenticate(...)' es el método de BCrypt que compara la contraseña escrita
    # con la versión encriptada (password_digest) que está en la base de datos.
    if user&.authenticate(params[:password])

      # 3. ÉXITO: Creamos la "Mochila de Sesión".
      # Guardamos el ID del usuario en 'session'. Esto es una cookie encriptada
      # que el navegador guardará. Así, la app "recordará" quién eres en cada clic.
      session[:user_id] = user.id

      # 4. Redireccionamos a la página de inicio con un mensaje de bienvenida.
      # Usamos #{user.nombre} para que el saludo sea personalizado.
      redirect_to root_path, notice: "¡Hola de nuevo, #{user.nombre}! Has iniciado sesión."

    else
      # 5. ERROR: Credenciales incorrectas.
      # 'flash.now' asegura que el mensaje de error aparezca solo ahora y desaparezca
      # si el usuario refresca la página o navega a otro lado.
      flash.now[:alert] = "Email o contraseña incorrectos. Intenta de nuevo."

      # Volvemos a mostrar el formulario (acción 'new') para que lo intente otra vez.
      # 'status: :unprocessable_entity' es el estándar moderno para errores de formulario.
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    # 1. Vaciamos la mochila de sesión poniendo el ID en 'nil' (nulo).
    # Al hacer esto, la app deja de reconocer al usuario inmediatamente.
    session[:user_id] = nil

    # 2. Mandamos al usuario de vuelta al inicio con un mensaje informativo.
    redirect_to root_path, notice: "Sesión cerrada. ¡Vuelve pronto!"
  end
end
