require_relative 'models/persona.rb'
require_relative 'models/mascota.rb'
require_relative 'controllers/TextController.rb'
require_relative 'controllers/PersonaController.rb'
require_relative 'controllers/MascotaController.rb'

def seleccionar_persona_mascota(archivo)
    begin
        puts("\n")
        if archivo == 'models/db/personas.txt'
            puts "Para Volver envia back, y para modificar una persona coloca el id de la persona:"
        else
            puts "Para Volver envia back, y para modificar una mascota coloca el id de la mascota:"
        end
    
        id_ingresado = gets.chomp
        
        if id_ingresado != "back" && !id_ingresado.match(/^\d+$/) # Verifica si la entrada contiene solo números
            raise "La entrada debe contener solo números."
        end
    
    rescue StandardError => e
        puts "Error: #{e.message}"
        retry
    end

    case id_ingresado
    when "back"
        inicio_programa()
    else
        if archivo == 'models/db/personas.txt'
            PersonaController.modificar_persona(id_ingresado)
        else
            MascotaController.modificar_mascota(id_ingresado)
        end
    end
end

def eliminar_persona_mascota(archivo)
    begin
        if archivo == 'models/db/personas.txt'
            puts "Para Volver envia back, y para eliminar una persona coloca el id de la persona:"
        else
            puts "Para Volver envia back, y para eliminar un animal coloca el id del animal:"
        end
    
        numero_ingresado = gets.chomp
        
        if numero_ingresado != "back" && !numero_ingresado.match(/^\d+$/) # Verifica si la entrada contiene solo números
            raise "La entrada debe contener solo números."
        end
    
    rescue StandardError => e
        puts "Error: #{e.message}"
        retry
    end

    case numero_ingresado
    when "back"
        inicio_programa()
    else
        if archivo == 'models/db/personas.txt'
            PersonaController.eliminar_id_del_txt(numero_ingresado)
        else
            MascotaController.eliminar_id_del_txt(numero_ingresado)
        end
        eliminar_persona_mascota(archivo)
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

            contiene_mascotas = MascotaController.mascota_vacio()
            if !contiene_mascotas
                puts "\n"
                raise "No hay ninguna mascota registrada, primero agrega una mascota"
            else
                puts "\n"
                MascotaController.mostrar_mascotas()
            end

        elsif (opcion == "5" || opcion == "3")

            contiene_personas = PersonaController.persona_vacio()
            if !contiene_personas
                puts "\n"
                raise "No hay ninguna persona registrada, primero agrega una persona"
            else
                puts "\n"
                PersonaController.mostrar_personas()
            end

        elsif (opcion != "1" && opcion != "2" && opcion != "0")
            puts "\n"
            raise "No existe la opcion solicitada, vuelve a intentarlo"
        end

    rescue StandardError => e
        puts "Error: #{e.message}"
        puts "\n"
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
            puts "Ingresa un documento de 8 dígitos:"
            documento = gets.chomp
          
            if documento.length != 8
              raise "El documento debe tener exactamente 8 dígitos."
            end
          
            documento_numero_entero = Integer(documento)
        rescue ArgumentError
            puts "\nLa entrada no es un número entero válido."
            retry
        rescue StandardError => e
            puts "\nError: #{e.message}"
            retry
        end
          
          

        puts "Ingresa un Domicilio:"
        domicilio = gets.chomp

        puts "Ingresa un el id de tus mascotas:"
        mascotas_input = gets.chomp
        mascotas = mascotas_input.split(',').map(&:strip)
        

        personaCreada = Persona.new(nil, nombre, apellido, documento_numero_entero, domicilio, mascotas)
        PersonaController.guardar_persona(personaCreada)


        puts "\n"
        puts "Persona registrada con exito"
        puts "\n"

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

        mascotaCreada = Mascota.new(nil, mascota_nombre, fecha_nacimiento, mascota_genero, mascota_tipo, mascota_raza)
        MascotaController.guardar_mascota(mascotaCreada)

        puts "\n"
        puts "Mascota registrada con exito"
        puts "\n"

        inicio_programa()
    when "3"
        seleccionar_persona_mascota('models/db/personas.txt')
    when "4"
        seleccionar_persona_mascota('models/db/mascotas.txt')
    when "5"
        eliminar_persona_mascota('models/db/personas.txt')
    else
        eliminar_persona_mascota('models/db/mascotas.txt')
    end
end

inicio_programa()