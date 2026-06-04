class UsersController < ApplicationController
  before_action :require_login, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    user_data = params[:user] || params[:vendedor] || params[:cliente] || params[:administrador]
    user_type = user_data&.[](:type)
    @user = if ["Cliente", "Vendedor", "Administrador"].include?(user_type)
              user_type.constantize.new(user_params(user_data))
            else
              Cliente.new(user_params(user_data))
            end
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: I18n.t("users.registro_exitoso", tipo: @user.type)
    else
      flash.now[:alert] = @user.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    user_data = params[:user] || params[:vendedor] || params[:cliente] || params[:administrador]
    user_data.delete(:password) if user_data[:password].blank?
    user_data.delete(:password_confirmation) if user_data[:password_confirmation].blank?
    if @user.update(user_params_edit)
      redirect_to root_path, notice: I18n.t("users.perfil_actualizado")
    else
      flash.now[:alert] = @user.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  # ACCIÓN: Muestra el perfil público de cualquier usuario
  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      redirect_to root_path, alert: "Usuario no encontrado"
      return
    end
    if @user.is_a?(Vendedor)
      @productos = Producto.visibles.where(vendedor_id: @user.id)
    end
  end

  private

  def user_params(data)
    data.permit(:nombre, :email, :password, :type)
  end

  def user_params_edit
    user_data = params[:user] || params[:cliente] || params[:vendedor] || params[:administrador]
    user_data.permit(:nombre, :email, :url_foto, :password, :password_confirmation)
  end

  def require_login
    unless current_user
      redirect_to login_path, alert: I18n.t("users.iniciar_sesion_primero")
    end
  end
end