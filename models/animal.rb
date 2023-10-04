require_relative '../controllers/TextController'

class Animal
  attr_accessor :tipo, :raza

  def initialize(tipo, raza)
    @tipo = tipo
    @raza = raza
  end

  def to_text
    TextController.serialize_to_text({
      tipo: @tipo,
      raza: @raza
    })
  end

  def self.from_text(text)
    data = TextController.deserialize_from_text(text)
    Animal.new(
      data[:tipo],
      data[:raza]
    )
  end
end
