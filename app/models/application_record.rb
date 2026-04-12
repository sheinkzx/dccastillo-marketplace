
class ApplicationRecord < ActiveRecord::Base # Define una clase que hereda de la gema ActiveRecord
  """
  Esta clase sirve para agregar una funcionalidad que tengan TODOS los modelos 
  (ej: un formato especial de fecha), si lo ponemos aquí todas las clases lo heredan 
  automáticamente.

  FLUJO: ActiveRecord::Base (Gema de Rails) → ApplicationRecord (Tu puente) → User (Tu modelo).
  """
  primary_abstract_class # Indica que esta clase no representa una tabla real, sino que es una base para las demás
end
