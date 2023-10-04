require_relative 'TextController'
require_relative '../models/mascota'

class MascotaController
  @@header = ""
  INITIAL_HEADER = "Persistencia de mascotas, 0\n"  # Encabezado inicial

  def self.guardar_mascota(mascota)
    # Leer el contenido actual del archivo mascotas.txt
    mascotas_text = File.read('models/db/mascotas.txt')

    if mascotas_text.empty?
      # Si está vacío, agregamos el encabezado
      mascotas_text = INITIAL_HEADER
    end

    # Si `empty?` es TRUE, significa que es la primera vez que se guarda una mascota
    if @@header.empty?
      # Obtener el último número del encabezado actual
      current_index = mascotas_text.match(/(\d+)$/).to_a.first.to_i

      # Calcular el próximo índice disponible
      next_index = current_index + 1

      # Actualizar el encabezado con el nuevo valor del contador
      mascotas_text.sub!(/(\d+)$/, next_index.to_s)

      # Asignar el valor de mascotaId a la mascota
      mascota.mascotaId = current_index
    end

    # Serializar la mascota y agregarla al archivo con el nuevo índice
    mascota_text = TextController.serialize_to_text({
      mascotaId: mascota.mascotaId,
      nombre: mascota.nombre,
      fechaNacimiento: mascota.fechaNacimiento,
      genero: mascota.genero,
      tipo: mascota.tipo,
      raza: mascota.raza
    })

    mascotas_text << "\n" << mascota_text

    # Escribir el contenido actualizado en el archivo mascotas.txt
    File.write('models/db/mascotas.txt', mascotas_text)
  end

  def self.cargar_mascotas
    mascotas = []

    # Leer el contenido del archivo mascotas.txt
    mascotas_text = File.read('models/db/mascotas.txt')

    # Verificar si el archivo contiene el encabezado
    mascotas_text.sub!(@@header, '') if mascotas_text.start_with?(@@header)

    # Dividir el texto en registros de mascotas usando "\n\n"
    mascotas_data = mascotas_text.split("\n\n")

    # Iterar a través de los registros y crear objetos Mascota
    mascotas_data.each do |mascota_text|
      mascota = TextController.deserialize_from_text(mascota_text, Mascota)
      mascotas << mascota
    end

    mascotas
  end

  def self.mascota_vacio()
    lineas = File.readlines('models/db/mascotas.txt')

    indice_linea = lineas.index { |linea| linea.include?("mascotaId: ") }
    
    if indice_linea.nil?
        return false
    end

    return true
  end

  def self.modificar_mascota(id)
    # Lee todo el contenido del archivo de mascotas
    mascotas = File.readlines('models/db/mascotas.txt')
  
    # Busca la línea que contiene el ID especificado
    indice_linea = mascotas.index { |linea| linea.include?("mascotaId: #{id}") }
  
    if indice_linea.nil?
      puts "No se encontró una mascota con el ID #{id}."
      puts("\n")
      mostrar_mascotas()
      seleccionar_persona_mascota('models/db/mascotas.txt')
      return # Agrega un return para salir del método en este caso.
    end

    begin
      # Muestra la información actual de la mascota
      puts "Información actual de la mascota:"
      puts("\n")
      puts mascotas[indice_linea, 6] # Muestra las 6 líneas desde la línea del ID
      puts "\n"

      puts "0: Volver"
      puts "1: Modificar Nombre"
      puts "Por favor, selecciona alguna de las opciones de arriba colocando el número:"

      opcion_modificar_mascota = gets.chomp
        
      if (opcion_modificar_mascota != "1" && opcion_modificar_mascota != "0")
        raise "No existe la opción solicitada, vuelve a intentarlo"
      end
    
    rescue StandardError => e
      puts "Error: #{e.message}"
      retry
    end

    puts("\n")
    case opcion_modificar_mascota
    when "0"
      mostrar_mascotas()
      seleccionar_persona_mascota('models/db/mascotas.txt')
    when "1"
      puts "Ingresa el nuevo nombre:"
      nuevo_nombre = gets.chomp
  
      # Actualiza la información en el arreglo de mascotas
      mascotas[indice_linea + 1] = "nombre: #{nuevo_nombre}\n"
    end
    # Vuelve a escribir todas las líneas en el archivo
    File.open('models/db/mascotas.txt', "w") do |archivo|
      archivo.puts mascotas
    end
  
    puts("\n")
    puts "Mascota con ID #{id} modificada correctamente."
    puts("\n")
    MascotaController.mostrar_mascotas()
    seleccionar_persona_mascota('models/db/mascotas.txt')
  end

  def self.eliminar_id_del_txt(id)
    lineas = File.readlines('models/db/mascotas.txt')

    # Encuentra la línea que contiene el ID a eliminar
    indice_linea = lineas.index { |linea| linea.include?("mascotaId: #{id}") }
    
    if indice_linea.nil?
        puts "No se encontró una mascota con el ID #{id}."
        return
    end
  
    # Ajusta los IDs de las personas restantes
    lineas.slice!(indice_linea, 7) # 7 para eliminar la línea con el ID y las siguientes 6 líneas

  
    # Vuelve a escribir todas las líneas restantes en el archivo
    File.open('models/db/mascotas.txt', "w") do |archivoM|
        archivoM.puts lineas
    end

    puts "Mascota con ID #{id} eliminada correctamente."
    
    MascotaController.mostrar_mascotas()
  end

  def self.mostrar_mascotas
    # Llamar al método cargar_mascotas para obtener la lista de mascotas
    mascotas = cargar_mascotas

    # Iterar a través de la lista de mascotas y mostrar sus detalles
    mascotas.each_with_index do |mascota, index|
      next if index == 0 # Salta la primera iteración

      puts "Mascota ID: #{mascota.mascotaId}"
      puts "Nombre: #{mascota.nombre}"
      puts "Fecha de Nacimiento: #{mascota.fechaNacimiento}"
      puts "Género: #{mascota.genero}"
      puts "Tipo: #{mascota.tipo}"
      puts "Raza: #{mascota.raza}"
      puts "------------------------"
    end
  end

  private # Métodos privados
end





