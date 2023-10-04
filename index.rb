require_relative 'models/persona.rb'
require_relative 'models/mascota.rb'
require_relative 'controllers/TextController.rb'
require_relative 'controllers/PersonaController.rb'
require_relative 'controllers/MascotaController.rb'


=begin 
persona = Persona.new(1, 'Juan', 'Pérez', 12345678, 'Calle 123, Ciudad')

persona_text = persona.to_text

puts "Texto serializado de la persona:"
puts persona_text

# Deserializar la persona desde el texto
persona_deserializada = Persona.from_text(persona_text)

# Mostrar los datos de la persona deserializada
puts "\nPersona deserializada:"
puts "ID: #{persona_deserializada.personaId}"
puts "Nombre: #{persona_deserializada.nombre}"
puts "Apellido: #{persona_deserializada.apellido}"
puts "DNI: #{persona_deserializada.dni}"
puts "Domicilio: #{persona_deserializada.domicilio}"
=end

# index.rb

=begin

=end

# puts "Ingrese los datos de la persona:"
# print "Nombre: "
# nombre = gets.chomp
# print "Apellido: "
# apellido = gets.chomp
# print "DNI: "
# dni = gets.chomp.to_i
# print "Domicilio: "
# domicilio = gets.chomp

# # Solicitar mascotas al usuario y convertirlas en un arreglo
# print "Mascotas (separadas por comas, presione Enter si no tiene): "
# mascotas_input = gets.chomp
# mascotas = mascotas_input.split(',').map(&:strip)

# # Crear una instancia de Persona con los datos ingresados
# persona = Persona.new(nil, nombre, apellido, dni, domicilio, mascotas)

# # Guardar la persona en el archivo personas.txt usando PersonaController
# PersonaController.guardar_persona(persona)

puts "La persona ha sido guardada exitosamente en personas.txt."
PersonaController.mostrar_personas
# Crea una instancia de Mascota con los datos deseados


=begin

def obtener_datos_mascota
    print "Nombre de la mascota: "
    nombre = gets.chomp
  
    print "Fecha de Nacimiento: "
    fecha_nacimiento = gets.chomp
  
    print "Género: "
    genero = gets.chomp
  
    print "Tipo: "
    tipo = gets.chomp
  
    print "Raza: "
    raza = gets.chomp
  
    { nombre: nombre, fecha_nacimiento: fecha_nacimiento, genero: genero, tipo: tipo, raza: raza }
  end
  
  # Obtener los datos de la mascota
  datos_mascota = obtener_datos_mascota
  
  # Crear una instancia de Mascota con los datos obtenidos
  mascota = Mascota.new(nil, datos_mascota[:nombre], datos_mascota[:fecha_nacimiento], datos_mascota[:genero], datos_mascota[:tipo], datos_mascota[:raza])

  mascota = Mascota.new(1, "Firulais", "2020-01-15", "Macho", "Perro", "Labrador")
  # Guardar la mascota en el archivo mascotas.txt usando MascotaController
  
  MascotaController.guardar_mascota(mascota)

  MascotaController.mostrar_mascotas
  
  puts "Mascota guardada con éxito!"

=end


