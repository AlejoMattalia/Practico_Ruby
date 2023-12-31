class TextController
  def self.serialize_to_text(data)
    text = ""
    data.each do |key, value|
      if value.is_a?(Array)
        text << "#{key}[]: #{value.join('-')}\n"
      else
        text << "#{key}: #{value}\n"
      end
    end
    text
  end
  
    def self.deserialize_from_text(text, klass)
      data = {}
    
      text.each_line do |line|
        line = line.strip
        key, value = line.split(': ', 2)
    
        unless key.nil? || key.empty? || value.nil?
          if key.end_with?('[]')
            key = key[0..-3].to_sym
            data[key] = value.split('-')
          else
            data[key.to_sym] = value
          end
        end
      end
    
      if klass == Persona
        objeto = Persona.new(data[:personaId], data[:nombre], data[:apellido], data[:dni], data[:domicilio], data[:mascotas] || [])
      elsif klass == Mascota
        objeto = Mascota.new(data[:mascotaId], data[:nombre], data[:fechaNacimiento], data[:genero], data[:tipo], data[:raza], data[:personaId])
      else
        objeto = nil
      end
    
      return objeto
    end
  end
  