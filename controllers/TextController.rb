

=begin
      class TextController 
    def self.serialize_to_text(data) #Le tengo que pasar un HASH como parametro
        text = ""
        data.each do |key, value|
          text << "#{key}: #{value}\n"
        end
        text
      end

    def self.deserialize_from_text(text)
        data = {}
    
        text.each_line do |line|
        # Eliminar espacios en blanco al principio y al final de la línea
        line = line.strip
    
        # Dividir la línea en clave y valor
        key, value = line.split(': ', 2)
    
        # Verificar si key y value no son nil ni vacíos antes de agregarlos a data
        unless key.nil? || key.empty? || value.nil?
            data[key.to_sym] = value
        end
    end
  
        # Crear una instancia de Persona y asignar los valores a los atributos
        persona = Persona.new(data[:personaId], data[:nombre], data[:apellido], data[:dni], data[:domicilio], data[:mascotas])
  
        return persona
    end   

end
=end

class TextController
    def self.serialize_to_text(data)
      text = ""
      data.each do |key, value|
        text << "#{key}: #{value}\n"
      end
      text
    end
  
    def self.deserialize_from_text(text, klass)
      data = {}
  
      text.each_line do |line|
        # Eliminar espacios en blanco al principio y al final de la línea
        line = line.strip
  
        # Dividir la línea en clave y valor
        key, value = line.split(': ', 2)
  
        # Verificar si key y value no son nil ni vacíos antes de agregarlos a data
        unless key.nil? || key.empty? || value.nil?
          data[key.to_sym] = value
        end
      end
  
      # Crear una instancia del tipo especificado (Persona o Mascota) y asignar los valores a los atributos
      if klass == Persona
        # Verificar si la clave :mascotas existe en data y si es un arreglo
        if data.key?(:mascotas) && data[:mascotas].start_with?("[") && data[:mascotas].end_with?("]")
          # Si es un arreglo, conviértelo a un arreglo de enteros
          data[:mascotas] = data[:mascotas].scan(/"(\d+)"/).flatten.map { |m| m.gsub(/\s+/, '').delete('"').to_i }
        else
          # Si no es un arreglo, asigna un arreglo vacío
          data[:mascotas] = []
        end
      
        objeto = Persona.new(data[:personaId], data[:nombre], data[:apellido], data[:dni], data[:domicilio], data[:mascotas])
      elsif klass == Mascota
        objeto = Mascota.new(data[:mascotaId], data[:nombre], data[:fechaNacimiento], data[:genero], data[:tipo], data[:raza])
      else
        objeto = nil
      end
  
      return objeto
    end
  end
  