Rails.application.routes.draw do
  """
  Esta clase es el enrutador. Recibe la petición del navegador y 
  la manda al 'cerebro' (controlador) correcto según la dirección (ruta) que hayan pedido.

  NOTA:: voy a seguir la estructura METODO 'nombre_ruta_que_quiero', to: 'controlador#acción'

  """
  get "up" => "rails/health#show", as: :rails_health_check


  get 'signup', to: 'users#new' # Ruta para mostrar el formulario de registro 

  post 'users', to: 'users#create' # Ruta para procesar el formulario de registro 
  

  root "users#new" # "root" es quien define donde comienza la paguina cuando el usuario entra a la URL base 
  #(localhost:3000) y lo redirige a la acción new del controlador users, que es donde se muestra el formulario de registro. 

end
