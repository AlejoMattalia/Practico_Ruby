require_relative 'TextController'
require_relative '../models/persona'

class PersonaController
  @@header = ""
  INITIAL_HEADER = "Persistencia de personas, 0\n"  # Encabezado inicial

  def self.guardar_persona(persona)
    # Leer el contenido actual del archivo personas.txt
    personas_text = File.read('models/db/personas.txt')

    if personas_text.empty?
      # Si está vacío, agregamos el encabezado
      personas_text = INITIAL_HEADER
    end

    # Si `empty?` es TRUE, significa que es la primera vez que se guarda una persona
    if @@header.empty?
      # Obtener el último número del encabezado actual
      current_index = personas_text.match(/(\d+)$/).to_a.first.to_i

      # Calcular el próximo índice disponible
      next_index = current_index + 1

      # Actualizar el encabezado con el nuevo valor del contador
      personas_text.sub!(/(\d+)$/, next_index.to_s)

      # Asignar el valor de personaId a la persona
      persona.personaId = current_index
    end

    # Serializar la persona y agregarla al archivo con el nuevo índice
    persona_text = TextController.serialize_to_text({
      personaId: persona.personaId,
      nombre: persona.nombre,
      apellido: persona.apellido,
      dni: persona.dni,
      domicilio: persona.domicilio,
      mascotas: persona.mascotas
    })

    personas_text << "\n" << persona_text << "\n"

    # Escribir el contenido actualizado en el archivo personas.txt
    File.write('models/db/personas.txt', personas_text)
  end

  def self.cargar_personas
    personas = []

    # Leer el contenido del archivo personas.txt
    personas_text = File.read('models/db/personas.txt')

    # Verificar si el archivo contiene el encabezado
    personas_text.sub!(@@header, '') if personas_text.start_with?(@@header)

    # Dividir el texto en registros de personas usando "\n\n"
    personas_data = personas_text.split("\n\n")

    # Iterar a través de los registros y crear objetos Persona
    personas_data.each do |persona_text|
      persona = TextController.deserialize_from_text(persona_text, Persona)
    
      # Verificar si persona.mascotas es un arreglo
      if !persona.mascotas.is_a?(Array)
        # Si no es un arreglo, entonces procesa la cadena de mascotas
        persona.mascotas = persona.mascotas.gsub(/\[|\]/, "").split(',').map(&:to_i)
      end

      personas << persona 
    end

    personas
  end

def self.mostrar_personas
    # Llamar al método cargar_personas para obtener la lista de personas
    personas = cargar_personas
  
    # Crear un hash para mapear IDs de mascotas a nombres
    # mascotas_nombres = obtener_nombres_de_mascotas
  
    # Iterar a través de la lista de personas y mostrar sus detalles
    personas.each_with_index do |persona, index|
      next if index == 0 # Salta la primera iteración
  
      puts "Persona ID: #{persona.personaId}"
      puts "Nombre: #{persona.nombre}"
      puts "Apellido: #{persona.apellido}"
      puts "DNI: #{persona.dni}"
      puts "Domicilio: #{persona.domicilio}"

      if persona.mascotas.any?

        nombres_mascotas = []

        persona.mascotas.map do |id|    
          # Convertir las cadenas de números en enteros y obtener los nombres de las mascotas
          nombre_mascota = obtener_nombres_de_mascotas(id)
          # Mostrar los nombres de las mascotas separados por comas
          nombres_mascotas << nombre_mascota
        end

        puts "Mascotas: #{nombres_mascotas.join(', ')}"
      else
        puts "Mascotas: 0"
      end
      puts "------------------------"
    end
  end
  
  # Un método para obtener un hash de IDs de mascotas a nombres de mascotas
  def self.obtener_nombres_de_mascotas(id)
    # Llamar al método cargar_mascotas para obtener la lista de mascotas
    mascotas = MascotaController.cargar_mascotas

    mascota_encontrada = mascotas.find { |mascota| mascota.mascotaId.to_i == id }

    nombre_mascota = mascota_encontrada.nombre

    return nombre_mascota
  
  end
  
  private # Métodos privados
end