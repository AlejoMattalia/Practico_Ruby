begin
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
        file = File.open("personas.txt", "r")
        posicion = 0
        personas = []
        file.each_line do |linea|
            personas[posicion] = linea
            puts personas[posicion]
            posicion += 1
        end

        file.close
        if personas.empty? 
            raise "No hay ninguna persona registrada, primero agrega una persona"
        end
    elsif (opcion != "1" && opcion != "2")
        raise "No existe la opcion solicitada, vuelve a intentarlo"
    end

rescue StandardError => e
    puts "Error: #{e.message}"
    retry
end




case opcion
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

when "2"
    puts "elejiste el 2"
when "3"
    puts "elejiste el 3"
when "4"
    puts "elejiste el 4"
when "5"
    puts "elejiste el 5"
else
    puts "elejiste el 6"
end