$personas = []
def guardar_personas()
    file = File.open("personas.txt", "r")
    posicion = 0
    file.each_line do |linea|
        $personas[posicion] = linea
        puts $personas[posicion]
        posicion += 1
    end
    
    file.close
end

$mascotas = []
def guardar_mascotas()
    file = File.open("mascotas.txt", "r")
    posicion = 0
    file.each_line do |linea|
        $mascotas[posicion] = linea
        puts $mascotas[posicion]
        posicion += 1
    end
    
    file.close
end
    
def seleccionar_persona()
    begin
        puts "0: Volver"
        puts "1: Seleccionar Persona por id"
        
        puts "Por favor, selecciona alguna de las opciones de arriba colocando el numero:"
    
        opcion_seleccionada = gets.chomp

        if opcion_seleccionada != "1" && opcion_seleccionada != "0"
            raise "No existe la opcion solicitada, vuelve a intentarlo"
        end
    
    rescue StandardError => e
        puts "Error: #{e.message}"
        retry
    end

    case opcion_seleccionada
    when "0"
        inicio_programa()
    when "1"
        modificar_persona()
    end
end

def seleccionar_persona_mascota(archivo)
    begin
        puts("\n")
        if archivo == "personas.txt"
            puts "Para Volver envia 0, y para modificar una persona coloca el id de la persona:"
        else
            puts "Para Volver envia 0, y para modificar una mascota coloca el id de la mascota:"
        end
    
        id_ingresado = gets.chomp
        
        if !id_ingresado.match(/^\d+$/) # Verifica si la entrada contiene solo números
            raise "La entrada debe contener solo números."
        end
    
    rescue StandardError => e
        puts "Error: #{e.message}"
        retry
    end

    case id_ingresado
    when "0"
        inicio_programa()
    else
        if archivo == "personas.txt"
            modificar_persona(id_ingresado)
        else
            modificar_mascota(id_ingresado)
        end
    end
end

def modificar_persona(id)
    # Lee todo el contenido del archivo de personas
    personas = File.readlines("personas.txt")
  
    # Busca la línea que contiene el ID especificado
    indice_linea = personas.index { |linea| linea.include?("ID: #{id}") }
  
    if indice_linea.nil?
      puts "No se encontró una persona con el ID #{id}."
      puts("\n")
      guardar_personas()
      seleccionar_persona_mascota("personas.txt")
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
        puts "4: Modificar Mascotas de la persona" #FALTA 
        
        puts "Por favor, selecciona alguna de las opciones de arriba colocando el numero:"
    
        opcion_modificar_persona = gets.chomp
        
        if (opcion_modificar_persona != "1" && opcion_modificar_persona != "2" && opcion_modificar_persona != "0" && opcion_modificar_persona != "3" && opcion_modificar_persona != "4")
            raise "No existe la opcion solicitada, vuelve a intentarlo"
        end
    
    rescue StandardError => e
        puts "Error: #{e.message}"
        retry
    end

    puts("\n")
    case opcion_modificar_persona
    when "0"
        guardar_personas()
        seleccionar_persona_mascota("personas.txt")
    when "1"
        puts "Ingresa el nuevo nombre:"
        nuevo_nombre = gets.chomp
  
        # Actualiza la información en el arreglo de personas
        personas[indice_linea + 1] = "Nombre: #{nuevo_nombre}\n"
    when "2"
        puts "Ingresa el nuevo apellido:"
        nuevo_apellido = gets.chomp
    
        # Actualiza la información en el arreglo de personas
        personas[indice_linea + 2] = "Apellido: #{nuevo_apellido}\n"
    
    when "3"
        puts "Ingresa el nuevo domicilio:"
        nuevo_domicilio = gets.chomp
    
        # Actualiza la información en el arreglo de personas
        personas[indice_linea + 4] = "Domicilio: #{nuevo_domicilio}\n"
    when "4" #MODIFICAR, MOSTRAR MASCOTAS QUE NO CONTIENEN DUEÑOS(POSIBLE SOLUCION: PONER EN CADA MASCOTA SI TIENE DUEÑO O NO)

    end
    # Vuelve a escribir todas las líneas en el archivo
    File.open("personas.txt", "w") do |archivo|
    archivo.puts personas
    end
  
    puts("\n")
    puts "Persona con ID #{id} modificada correctamente."
    puts("\n")
    guardar_personas()
    seleccionar_persona_mascota("personas.txt")
end

def modificar_mascota(id) #FALTA HACER BIEN
    # Lee todo el contenido del archivo de personas
    mascotas = File.readlines("mascotas.txt")
  
    # Busca la línea que contiene el ID especificado
    indice_linea = mascotas.index { |linea| linea.include?("ID: #{id}") }
  
    if indice_linea.nil?
      puts "No se encontró una mascota con el ID #{id}."
      puts("\n")
      guardar_mascotas()
      seleccionar_persona_mascota("mascotas.txt")
    end

    begin
        # Muestra la información actual de la persona
        puts "Información actual de la persona:"
        puts("\n")
        puts mascotas[indice_linea, 6] # Muestra las 6 líneas desde la línea del ID
        puts "\n"

        puts "0: Volver"
        puts "1: Modificar Nombre" #FALTA 
        
        puts "Por favor, selecciona alguna de las opciones de arriba colocando el numero:"
    
        opcion_modificar_mascota = gets.chomp
        
        if (opcion_modificar_mascota != "1" && opcion_modificar_mascota != "0")
            raise "No existe la opcion solicitada, vuelve a intentarlo"
        end
    
    rescue StandardError => e
        puts "Error: #{e.message}"
        retry
    end

    puts("\n")
    case opcion_modificar_mascota
    when "0"
        guardar_mascotas()
        seleccionar_persona_mascota("mascotas.txt")
    when "1"
        puts "Ingresa el nuevo nombre:"
        nuevo_nombre = gets.chomp
  
        # Actualiza la información en el arreglo de mascotas
        mascotas[indice_linea + 1] = "Nombre: #{nuevo_nombre}\n"
    end
    # Vuelve a escribir todas las líneas en el archivo
    File.open("mascotas.txt", "w") do |archivo|
    archivo.puts mascotas
    end
  
    puts("\n")
    puts "Mascota con ID #{id} modificada correctamente."
    puts("\n")
    guardar_mascotas()
    seleccionar_persona_mascota("mascotas.txt")
end

def eliminar_persona_mascota(archivo)
    begin
        if archivo == "persona.txt"
            puts "Para Volver envia 0, y para eliminar una persona coloca el id de la persona:"
        else
            puts "Para Volver envia 0, y para eliminar un animal coloca el id del animal:"
        end
    
        numero_ingresado = gets.chomp
        
        if !numero_ingresado.match(/^\d+$/) # Verifica si la entrada contiene solo números
            raise "La entrada debe contener solo números."
        end
    
    rescue StandardError => e
        puts "Error: #{e.message}"
        retry
    end

    case numero_ingresado
    when "0"
        inicio_programa()
    else
        eliminar_id_del_txt(numero_ingresado, archivo)
    end
end

def eliminar_id_del_txt(id, archivo)
    lineas = File.readlines(archivo)
    
    # Encuentra la línea que contiene el ID a eliminar
    indice_linea = lineas.index { |linea| linea.include?("ID: #{id}") }
    
    if indice_linea.nil?
        puts "No se encontró una persona/mascota con el ID #{id}."
        return
    end
  
    # Ajusta los IDs de las personas/mascotas restantes
    lineas.slice!(indice_linea, 7) # 7 para eliminar la línea con el ID y las siguientes 6 líneas
    id_eliminado = id.to_i
    lineas.each_with_index do |linea, index|
        if linea.include?("ID:")
            id_actual = linea.scan(/\d+/).first.to_i
            nuevo_id = id_actual - 1
            lineas[index] = "ID: #{nuevo_id}\n"
        end
    end
  
    # Vuelve a escribir todas las líneas restantes en el archivo
    File.open(archivo, "w") do |archivoM|
        archivoM.puts lineas
    end
  
    if archivo == "personas.txt"
        puts "Persona con ID #{id} eliminada correctamente."
        guardar_personas()
    else
        puts "Mascota con ID #{id} eliminada correctamente."
        guardar_mascotas()
    end
    eliminar_persona_mascota(archivo)
end
  

$id_inicio_persona = 1
$id_inicio_mascota = 1
def inicio_programa()

    begin
        puts "0: Salir"
        puts "1: Aregar Persona"
        puts "2: Aregar Mascota"
        puts "3: Modificar Persona"
        puts "4: Modificar Mascota"
        puts "5: Eliminar Persona"
        puts "6: Eliminar Mascota"
        
        puts "Por favor, selecciona alguna de las opciones de arriba colocando el numero:"

        opcion = gets.chomp
        
        if (opcion == "4" || opcion == "6")

            guardar_mascotas()

            if $mascotas.empty? 
                raise "No hay ninguna mascota registrada, primero agrega una mascota"
            end
        elsif (opcion == "5" || opcion == "3")

            guardar_personas()

            if $personas.empty? 
                raise "No hay ninguna persona registrada, primero agrega una persona"
            end
        elsif (opcion != "1" && opcion != "2" && opcion != "0")
            raise "No existe la opcion solicitada, vuelve a intentarlo"
        end

    rescue StandardError => e
        puts "Error: #{e.message}"
        retry
    end

    case opcion
    when "0"
        puts "Programa terminado con exito"
    when "1"
        puts "Ingresa un Nombre:"
        nombre = gets.chomp

        puts "Ingresa un Apellido:"
        apellido = gets.chomp

        begin
            puts "Ingresa un documento:"
            documento = gets.chomp
            documento_numero_entero = Integer(documento)
        rescue ArgumentError
            puts "La entrada no es un número entero válido."
            retry
        end

        puts "Ingresa un Domicilio:"
        domicilio = gets.chomp

        file = File.open("personas.txt", "a")

        file.puts "\nID: #{$id_inicio_persona}"
        file.puts "Nombre: #{nombre}"
        file.puts "Apellido: #{apellido}"
        file.puts "DNI: #{documento_numero_entero}"
        file.puts "Domicilio: #{domicilio}"
        file.puts "Mascotas: "

        file.close

        puts "Persona registrada con exito"
        $id_inicio_persona += 1

        inicio_programa()

    when "2"
        puts "Ingresa nombre de la mascota:"
        mascota_nombre = gets.chomp

        puts "Ingresa fecha de nacimiento de la mascota:"
        fecha_nacimiento = gets.chomp

        puts "Ingresa genero de la mascota:"
        mascota_genero = gets.chomp

        puts "Ingresa que tipo de mascota es (ej:perro/gato):"
        mascota_tipo = gets.chomp

        puts "Ingresa que tipo de raza es:"
        mascota_raza = gets.chomp

        file = File.open("mascotas.txt", "a")

        file.puts "\nID: #{$id_inicio_mascota}"
        file.puts "Nombre: #{mascota_nombre}"
        file.puts "Fecha de Nacimiento: #{fecha_nacimiento}"
        file.puts "Genero: #{mascota_genero}"
        file.puts "Tipo: #{mascota_tipo}"
        file.puts "Raza: #{mascota_raza}"

        file.close

        puts "Mascota registrada con exito"
        $id_inicio_mascota += 1

        inicio_programa()
    when "3"
        seleccionar_persona_mascota("personas.txt")
    when "4"
        seleccionar_persona_mascota("mascotas.txt")
    when "5"
        eliminar_persona_mascota("personas.txt")
    else
        eliminar_persona_mascota("mascotas.txt")
    end
end

inicio_programa()