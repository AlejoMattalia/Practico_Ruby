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

def modificar_persona()
    begin
        puts "0: Volver"
        puts "1: Modificar Nombre"
        puts "2: Modificar Apellido"
        puts "3: Modificar Domicilio"
        puts "4: Modificar Mascotas"
        
        puts "Por favor, selecciona alguna de las opciones de arriba colocando el numero:"
    
        opcion_modificar_persona = gets.chomp
        
        if opcion_modificar_persona == "4"
            file = File.open("mascotas.txt", "r")
            posicion = 0
            mascotas = []
            file.each_line do |linea|
                mascotas[posicion] = linea
                puts mascotas[posicion]
                posicion += 1
            end
    
            file.close
            if mascotas.empty? 
                raise "No hay ninguna mascota registrada, primero agrega una mascota"
            end
        elsif (opcion_modificar_persona == "5" || opcion_modificar_persona == "3")
            
            guardar_personas()

            if $personas.empty? 
                raise "No hay ninguna persona registrada, primero agrega una persona"
            end
        elsif (opcion_modificar_persona != "1" && opcion_modificar_persona != "2" && opcion_modificar_persona != "0")
            raise "No existe la opcion solicitada, vuelve a intentarlo"
        end
    
    rescue StandardError => e
        puts "Error: #{e.message}"
        retry
    end

    case opcion_modificar_persona
    when "0"
        seleccionar_persona()
    end
end

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
            file = File.open("mascotas.txt", "r")
            posicion = 0
            mascotas = []
            file.each_line do |linea|
                mascotas[posicion] = linea
                puts mascotas[posicion]
                posicion += 1
            end

            file.close
            if mascotas.empty? 
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

        file.puts "\nNombre: #{nombre}"
        file.puts "Apellido: #{apellido}"
        file.puts "DNI: #{documento_numero_entero}"
        file.puts "Domicilio: #{domicilio}"
        file.puts "Mascotas: "

        file.close

        puts "Persona registrada con exito"

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

        file.puts "\nNombre: #{mascota_nombre}"
        file.puts "Fecha de Nacimiento: #{fecha_nacimiento}"
        file.puts "Genero: #{mascota_genero}"
        file.puts "Tipo: #{mascota_tipo}"
        file.puts "Raza: #{mascota_raza}"

        file.close

        puts "Mascota registrada con exito"

        inicio_programa()
    when "3"
        seleccionar_persona()
    when "4"
        puts "elejiste el 4"
    when "5"
        puts "elejiste el 5"
    else
        puts "elejiste el 6"
    end
end

inicio_programa()