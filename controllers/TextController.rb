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
        objeto = Persona.new(data[:personaId], data[:nombre], data[:apellido], data[:dni], data[:domicilio], data[:mascotas])
      elsif klass == Mascota
        objeto = Mascota.new(data[:mascotaId], data[:nombre], data[:fechaNacimiento], data[:genero], data[:tipo], data[:raza])
      else
        objeto = nil
      end
  
      return objeto
    end
  end
  