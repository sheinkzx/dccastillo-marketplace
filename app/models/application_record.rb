class ApplicationRecord < ActiveRecord::Base # Define una clase que hereda de la gema ActiveRecord
  primary_abstract_class # Indica que esta clase no representa una tabla real, sino que es una base para las demás
end
