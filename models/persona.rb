require_relative '../controllers/TextController'

class Persona
  attr_accessor :personaId, :nombre, :apellido, :dni, :domicilio, :mascotas

  def initialize(personaId, nombre, apellido, dni, domicilio, mascotas = [])
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
end