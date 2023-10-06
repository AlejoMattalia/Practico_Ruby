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
  end
