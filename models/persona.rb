require_relative '../controllers/TextController'
require_relative '../controllers/MascotaController'

class Persona
  attr_accessor :personaId, :nombre, :apellido, :dni, :domicilio, :mascotas

  def initialize(personaId, nombre, apellido, dni, domicilio, mascotas = [])

  # Verifica si las mascotas existen
  verificar_existencia_de_mascotas(mascotas)
  # Verifica si las mascotas tienen la propiedad personaId asignada
  verificar_propiedad_persona_id(mascotas)

    @personaId = personaId
    @nombre = nombre
    @apellido = apellido
    @dni = dni
    @domicilio = domicilio
    @mascotas = mascotas.is_a?(Array) ? mascotas : []
  end

  def to_text
    TextController.serialize_to_text({
      personaId: @personaId,
      nombre: @nombre,
      apellido: @apellido,
      dni: @dni,
      domicilio: @domicilio,
      mascotas: @mascotas
    })
  end

  def self.from_text(text)
    data = TextController.deserialize_from_text(text)
    Persona.new(
      data[:personaId].to_i,
      data[:nombre],
      data[:apellido],
      data[:dni].to_i,
      data[:domicilio],
      data[:mascotas]
    )
  end

private

  def verificar_existencia_de_mascotas(mascotas)
    mascotas.each do |mascota|
      unless MascotaController.cargar_mascotas.any? { |m| m.mascotaId.to_i == mascota.to_i }
        raise MascotaNoExistente, "La mascota que desea asignar no existe."
      end
    end
  end

  def verificar_propiedad_persona_id(mascotas)
    mascotas.each do |mascota|
      if MascotaController.cargar_mascotas.any? { |m| m.mascotaId.to_i == mascota.to_i && m.personaId }
        raise MascotaYaAsignada, "La mascota que desea asignar ya tiene un valor en su propiedad personaId."
      end
    end
  end

end