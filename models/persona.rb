require_relative '../controllers/TextController'
require_relative '../controllers/MascotaController'

class Persona
  attr_accessor :personaId, :nombre, :apellido, :dni, :domicilio, :mascotas

  def initialize(personaId, nombre, apellido, dni, domicilio, mascotas = [])

  # Verifica si las mascotas existen
  unless mascotas == nil
    MascotaController.verificar_existencia_de_mascotas(mascotas)
    # Verifica si las mascotas tienen la propiedad personaId asignada
    MascotaController.verificar_propiedad_persona_id(mascotas)
  end

    @personaId = personaId
    @nombre = nombre
    @apellido = apellido
    @dni = dni
    @domicilio = domicilio
    @mascotas = mascotas.is_a?(Array) ? mascotas : []
  end
end