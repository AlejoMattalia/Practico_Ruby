require_relative 'animal.rb'

class Mascota < Animal
    attr_accessor :mascotaId, :nombre, :fechaNacimiento, :genero
  
    def initialize(mascotaId, nombre, fechaNacimiento, genero, tipo, raza)
        super(tipo, raza) # Llama al constructor de la clase base (Animal)
        @mascotaId = mascotaId
        @nombre = nombre
        @fechaNacimiento = fechaNacimiento
        @genero = genero
    end
  
    def to_text
        # Combinar los datos de la clase base (Animal) y la clase derivada (Mascota)
        animal_data = super.to_text
        mascota_data = TextController.serialize_to_text({
        mascotaId: @mascotaId,
        nombre: @nombre,
        fechaNacimiento: @fechaNacimiento,
        genero: @genero
        })
        "#{animal_data}\n#{mascota_data}"
    end
  
    def self.from_text(text)
      # Dividir el texto en datos de Animal y Mascota
      animal_data, mascota_data = text.split("\n", 2)
      
      # Deserializar datos de Animal y Mascota
      animal = Animal.from_text(animal_data)
      mascota = TextController.deserialize_from_text(mascota_data)
  
      # Crear una instancia de Mascota
      Mascota.new(
        mascota[:mascotaId].to_i,
        mascota[:nombre],
        mascota[:fechaNacimiento],
        mascota[:genero],
        animal.tipo,
        animal.raza
      )
    end
  end