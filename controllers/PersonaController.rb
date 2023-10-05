require_relative '../models/persona'
require_relative '../controllers/MascotaController'

class PersonaController < TextController
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
    persona_text = self.serialize_to_text({
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

=begin
    mascotas = MascotaController.cargar_mascotas
    persona.mascotas.each do |mascota_id|
      mascota_encontrada = mascotas.find { |m| m.mascotaId.to_i == mascota_id.to_i}
      if mascota_encontrada
        mascota_encontrada.personaId = persona.personaId
        mascota_actualizada_texto = MascotaController.actualizar_mascotas(mascota_encontrada)
        File.write('models/db/mascotas.txt', 
        File.read('models/db/mascotas.txt').gsub(/mascotaId: #{mascota_encontrada.mascotaId}\n(.+?)\n\n/m, 
        mascota_actualizada_texto + "\n\n"))
      end
    end
=end
  
  end

  #Devuelve una lista de objetos persona
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
      persona = self.deserialize_from_text(persona_text, Persona)
      personas << persona
    end

    personas
  end

=begin
  def self.mostrar_personas
    # Llamar al método cargar_personas para obtener la lista de personas
    personas = cargar_personas

    # Iterar a través de la lista de personas y mostrar sus detalles
    personas.each_with_index do |persona, index|
      next if index == 0 # Salta la primera iteración

      puts "Persona ID: #{persona.personaId}"
      puts "Nombre: #{persona.nombre}"
      puts "Apellido: #{persona.apellido}"
      puts "DNI: #{persona.dni}"
      puts "Domicilio: #{persona.domicilio}"

      if persona.mascotas.any?
        # Convertir las cadenas de números en enteros y luego unirlas
        mascotas_ids = persona.mascotas.map(&:to_i)
        # mascotas_nombres = obtener_nombres_de_mascotas(mascotas_ids)  # Reemplaza obtener_nombres_de_mascotas con la lógica adecuada

        # Mostrar los nombres de las mascotas separados por comas
        puts "Mascotas: #{mascotas_ids.join(', ')}"
      end
      puts "------------------------"
    end
  end
=end

def self.mostrar_personas
    # Llamar al método cargar_personas para obtener la lista de personas
    personas = cargar_personas
  
    # Crear un hash para mapear IDs de mascotas a nombres
    mascotas_nombres = obtener_nombres_de_mascotas
  
    # Iterar a través de la lista de personas y mostrar sus detalles
    personas.each_with_index do |persona, index|
      next if index == 0 # Salta la primera iteración
  
      puts "Persona ID: #{persona.personaId}"
      puts "Nombre: #{persona.nombre}"
      puts "Apellido: #{persona.apellido}"
      puts "DNI: #{persona.dni}"
      puts "Domicilio: #{persona.domicilio}"
  
      if persona.mascotas.length() > 0
        # Convertir las cadenas de números en enteros y obtener los nombres de las mascotas
        mascotas_nombres_persona = persona.mascotas.map { |mascota_id| mascotas_nombres[mascota_id] }
  
        # Mostrar los nombres de las mascotas separados por comas
        puts "Mascotas: #{mascotas_nombres_persona.join(', ')}"
      end
      puts "------------------------"
    end
  end
  
  private

  # Un método para obtener un hash de IDs de mascotas a nombres de mascotas
  def self.obtener_nombres_de_mascotas
    # Llamar al método cargar_mascotas para obtener la lista de mascotas
    mascotas = MascotaController.cargar_mascotas
  
    # Crear un hash que mapea IDs de mascotas a nombres de mascotas
    nombres_mascotas = {}
    mascotas.each do |mascota|
      nombres_mascotas[mascota.mascotaId] = mascota.nombre
    end
  
    nombres_mascotas
  end
  
end