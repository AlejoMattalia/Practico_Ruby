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

    personas_text << "\n" << persona_text

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
  
      if persona.mascotas.any?
        # Convertir las cadenas de números en enteros y obtener los nombres de las mascotas
        mascotas_nombres_persona = persona.mascotas.map { |mascota_id| mascotas_nombres[mascota_id.to_i] }
  
        # Mostrar los nombres de las mascotas separados por comas
        puts "Mascotas: #{mascotas_nombres_persona.join(', ')}"
      end
      puts "------------------------"
    end
  end

  def self.persona_vacio()
    lineas = File.readlines('models/db/personas.txt')

    indice_linea = lineas.index { |linea| linea.include?("personaId: ") }
    
    if indice_linea.nil?
        return false
    end

    return true
  end

  def self.eliminar_id_del_txt(id)
    lineas = File.readlines('models/db/personas.txt')

    # Encuentra la línea que contiene el ID a eliminar
    indice_linea = lineas.index { |linea| linea.include?("personaId: #{id}") }
    
    if indice_linea.nil?
        puts "No se encontró una persona con el ID #{id}."
        return
    end
  
    # Ajusta los IDs de las personas restantes
    lineas.slice!(indice_linea, 7) # 7 para eliminar la línea con el ID y las siguientes 6 líneas

  
    # Vuelve a escribir todas las líneas restantes en el archivo
    File.open('models/db/personas.txt', "w") do |archivoM|
        archivoM.puts lineas
    end

    puts "Persona con ID #{id} eliminada correctamente."

    PersonaController.mostrar_personas()
  end

  def self.modificar_persona(id)
    # Lee todo el contenido del archivo de personas
    personas = File.readlines('models/db/personas.txt')

    # Busca la línea que contiene el ID especificado
    indice_linea = personas.index { |linea| linea.include?("personaId: #{id}") }

    if indice_linea.nil?
      puts "No se encontró una persona con el ID #{id}."
      puts("\n")
      mostrar_personas()
      seleccionar_persona_mascota('models/db/personas.txt')
      return # Agrega un return para salir del método en este caso.
    end

    begin
      # Muestra la información actual de la persona
      puts "Información actual de la persona:"
      puts("\n")
      puts personas[indice_linea, 6] # Muestra las 6 líneas desde la línea del ID
      puts "\n"

      puts "0: Volver"
      puts "1: Modificar Nombre"
      puts "2: Modificar Apellido"
      puts "3: Modificar Domicilio"
      puts "4: Modificar Mascotas de la persona"
      puts "Por favor, selecciona alguna de las opciones de arriba colocando el número:"

      opcion_modificar_persona = gets.chomp

      if (opcion_modificar_persona != "1" && opcion_modificar_persona != "2" && opcion_modificar_persona != "0" && opcion_modificar_persona != "3" && opcion_modificar_persona != "4")
        raise "No existe la opción solicitada, vuelve a intentarlo"
      end

    rescue StandardError => e
      puts "Error: #{e.message}"
      retry
    end

    puts("\n")
    case opcion_modificar_persona
    when "0"
      mostrar_personas()
      seleccionar_persona_mascota('models/db/personas.txt')
    when "1"

      regex = /\A[\p{L}\s]+\z/
      begin
        puts "Ingresa el nuevo nombre:"
        nuevo_nombre = gets.chomp

        if !nuevo_nombre.match?(regex)
          raise "El nombre debe tener solo letras."
        end
      rescue StandardError => e
        puts "\nError: #{e.message}"
        retry
      end

      # Actualiza la información en el arreglo de personas
      personas[indice_linea + 1] = "nombre: #{nuevo_nombre}\n"
    when "2"

      regex = /\A[\p{L}\s]+\z/
      begin
        puts "Ingresa el nuevo apellido:"
        nuevo_apellido = gets.chomp

        if !nuevo_apellido.match?(regex)
          raise "El nombre debe tener solo letras."
        end
      rescue StandardError => e
        puts "\nError: #{e.message}"
        retry
      end

      # Actualiza la información en el arreglo de personas
      personas[indice_linea + 2] = "apellido: #{nuevo_apellido}\n"
    when "3"
      regex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z0-9\s.,#-]+$/
      begin
        puts "Ingresa el nuevo domicilio:"
        nuevo_domicilio = gets.chomp

        if nuevo_domicilio !~ regex
          raise "El domicilio debe tener letras y numeros."
        end
      rescue StandardError => e
        puts "\nError: #{e.message}"
        retry
      end

      # Actualiza la información en el arreglo de personas
      personas[indice_linea + 4] = "domicilio: #{nuevo_domicilio}\n"
    when "4"
      # Aquí puedes agregar la lógica para modificar las mascotas de la persona.
      # Puedes llamar a otros métodos o implementar la lógica necesaria.
    end

    # Vuelve a escribir todas las líneas en el archivo
    File.open('models/db/personas.txt', "w") do |archivo|
      archivo.puts personas
    end

    puts("\n")
    puts "Persona con ID #{id} modificada correctamente."
    puts("\n")
    PersonaController.mostrar_personas()
    seleccionar_persona_mascota('models/db/personas.txt')
  end
  
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
  
  private # Métodos privados
end