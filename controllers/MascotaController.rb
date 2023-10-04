require_relative '../models/mascota'

class MascotaController < TextController
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
    mascota_text = self.serialize_to_text({
      mascotaId: mascota.mascotaId,
      nombre: mascota.nombre,
      fechaNacimiento: mascota.fechaNacimiento,
      genero: mascota.genero,
      tipo: mascota.tipo,
      raza: mascota.raza
    })

    mascotas_text << "\n" << mascota_text << "\n"

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
      mascota = self.deserialize_from_text(mascota_text, Mascota)
      mascotas << mascota
    end

    mascotas
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





