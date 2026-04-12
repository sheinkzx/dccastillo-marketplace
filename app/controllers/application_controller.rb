class ApplicationController < ActionController::Base
  """
  Aquí más adelante se ponen cosas que afecten a toda la app, 
  como verificar que el usuario esté logueado antes de comprar.
  """

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes
end
