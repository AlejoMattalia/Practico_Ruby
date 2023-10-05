require_relative 'animal.rb'

class Mascota < Animal
    attr_accessor :mascotaId, :nombre, :fechaNacimiento, :genero, :personaId
  
    def initialize(mascotaId, nombre, fechaNacimiento, genero, tipo, raza, personaId)
        super(tipo, raza) # Llama al constructor de la clase base (Animal)
        @mascotaId = mascotaId
        @nombre = nombre
        @fechaNacimiento = fechaNacimiento
        @genero = genero
        @personaId = personaId
    end
  
    def to_text
        # Combinar los datos de la clase base (Animal) y la clase derivada (Mascota)
        animal_data = super.to_text
        mascota_data = TextController.serialize_to_text({
        mascotaId: @mascotaId,
        nombre: @nombre,
        fechaNacimiento: @fechaNacimiento,
        genero: @genero,
        personaId: @personaId
        })
        "#{animal_data}\n#{mascota_data}"
    end
  
    def self.from_text(text)
      # Dividir el texto en datos de Animal y Mascota
      animal_data, mascota_data = text.split("\n", 2)
      
      # Deserializar datos de Animal y Mascota
      animal = Animal.from_text(animal_data)
      mascota = TextController.deserialize_from_text(mascota_data, Mascota)
  
      # Crear una instancia de Mascota
      Mascota.new(
        mascota[:mascotaId].to_i,
        mascota[:nombre],
        mascota[:fechaNacimiento],
        mascota[:genero],
        mascota[:personaId],
        animal.tipo,
        animal.raza
      )
    end
  end