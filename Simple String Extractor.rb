# Solicitar al usuario el camino (path) del archivo .exe
puts "Ingresa el camino completo del archivo .exe a analizar (por ejemplo, C:\\Windows\\console.exe):"
path_archivo_exe = gets.chomp

begin
  # Leer el archivo binario .exe
  contenido_binario = File.binread(path_archivo_exe)

  # Especifica las cadenas que deseas buscar
  cadenas_a_buscar = [
    "System.Runtime.InteropServices",
    "System.Runtime.CompilerServices",
    "DebuggingModes",
    "GetBytes",
    "get_Headers",
    "Concat",
    "Object",
    "System.Net",
    "WebClient",

  ]

  # Crear un archivo de texto en el escritorio y guardar las cadenas en él
  escritorio = File.join(Dir.home, "Desktop")
  archivo_resultado = File.join(escritorio, "strings_encontradas.txt")

  File.open(archivo_resultado, "w") do |archivo_txt|
    archivo_txt.puts("Cadenas encontradas en el archivo #{path_archivo_exe}:\n\n")
    
    # Buscar y escribir las cadenas específicas
    cadenas_a_buscar.each do |cadena|
      contenido_binario.scan(/#{Regexp.escape(cadena)}.*/) do |match|
        archivo_txt.puts(match)
      end
    end
  end

  puts "Se han encontrado y guardado las cadenas en #{archivo_resultado}"

rescue StandardError => e
  puts "Error: #{e.message}"
end
