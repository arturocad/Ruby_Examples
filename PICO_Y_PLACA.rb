require 'gtk3'

class Time
   def initialize(h=0, m=0) #Se inicializa con pepito 
    @hh  = h #Hora string
    @min = m #Minutos sting
    @hhmm = 0
   end 
   
   def validar_hora
     if @hh.length == 2 and @min.length == 2
       if @hh[0]=~/[0-9]/ and @hh[1]=~/[0-9]/ and @min[0]=~/[0-9]/ and @min[1]=~/[0-9]/
           hora = @hh[0].to_i*10 + @hh[1].to_i
           minu = @min[0].to_i*10 + @min[1].to_i
           if hora < 24 and minu < 60
             puts "Hora: #{hora}:#{minu}"
             return true
           else
             puts "Hora no valida"
             return false
           end
           
       else
         puts "Hora no valida"
         return false
       end 
     else
       puts "Hora no valida"
       return false
     end
     
   end
   
   def get_hora
     @hhmm = @hh[0].to_i*1000 + @hh[1].to_i*100 + @min[0].to_i*10 + @min[1].to_i
     return @hhmm 
   end
  
end

class Plate_Number  
  def initialize(num_plate="0000") #Se inicializa con num placa
    @q = num_plate
  end
  
  def validar_plate_number   
   if @q.length == 7
      #Validar caracteres
      @q.upcase 
      if @q[0] =~ /[A-Za-z]/ and @q[1] =~ /[A-Za-z]/ and @q[2] =~ /[A-Za-z]/ and @q[3] =~/[0-9]/ and @q[6] =~ /[0-9]/ 
        puts "Placa Valida"
        return true
      elsif
        puts "Placa no valida"
        return false
      end
    elsif
      puts "Placa no valida"
      return false
    end 
  end
  
  def get_last_plate_number
    return(@q[6].to_i) 
  end
  
end

class Date
   def initialize(fecha=0) #Se inicializa con fecha
    @f = fecha #String con al fecha
    @dd = 0  #Dia
    @mm = 0  #Mes
    @yy = 0  #Anio
    @yb = false #bandera para anio bisiesto
   end
   
   def validar_fecha #Se valida Formato dd/mm/yyyy and > 1900
     if @f.length == 10  #Se verifica longitud de cadena de caracteres y formato de fecha
       if @f[0]=~/[0-9]/ and @f[1]=~/[0-9]/ and @f[2]=="/" and @f[3]=~/[0-9]/ and
          @f[4]=~/[0-9]/ and @f[5]=="/" and @f[6]=~/[0-9]/ and @f[7]=~/[0-9]/ and  @f[8]=~/[0-9]/ and @f[9]=~/[0-9]/
          
          @yy = @f[6].to_i*1000 + @f[7].to_i*100 + @f[8].to_i*10 + @f[9].to_i #Se obtiene el año
          @mm = @f[3].to_i*10 + @f[4].to_i                                    #Se obtiene el mes
          @dd = @f[0].to_i*10 + @f[1].to_i                                    #Se obtiene el dia
          
          #Se determina si es año bisiesto
          if @yy % 4 ==0 and (@yy % 100 != 0 or @yy % 400 == 0 )
            @yb = true #bandera de year bisiesto activada
            puts "Bisiesto"
          else
            @yb = false 
          end 
          
          if @yy > 1900 and @mm < 13 and @dd < 32 #Validar limites de dia, mes y año
            
            if @mm==2 #mes de febrero 
              if @yb
                if @dd < 30
                  puts "Fecha Valida: #{@dd}-#{@mm}-#{@yy}"
                  return true
                else
                  puts "Fecha no Valida"
                  return false 
                end
              else
                if @dd < 29
                  puts "Fecha Valida: #{@dd}-#{@mm}-#{@yy}"
                  return true
                else
                  puts "Fecha no Valida"
                  return false 
                end
              end
              
            elsif @mm == 4 or @mm == 6 or @mm == 9 or @mm == 11
              if @dd < 31
                  puts "Fecha Valida: #{@dd}-#{@mm}-#{@yy}"
                  return true
                else
                  puts "Fecha no Valida"
                  return false 
                end 
            else
              puts "Fecha Valida: #{@dd}-#{@mm}-#{@yy}"
              return true 
            end 
           
          else
            puts "Fecha no Valida"
            return false 
          end  
       else
          puts "Fecha no Valida"
          return false  
        end 
     else
       puts "Fecha no Valida"
      return false  
     end
   end
   
   def Week_day #Este metodo retorna el dia de la semana Lunes-Domingo 
        #Lunes: 1, Martes: 2, Miercoles: 3, Jueves: 4, Viernes: 5, Sabado: 6, Domingo: 0,
        a1 = (@yy - 1)/ 4;
        a2 = (@yy - 1)/ 100; 
        a3 = (@yy - 1)/ 400;
        day_start = (@yy + a1 - a2 + a3) %7; #Se calcula el primer dia del anio
        
        if @yb
          adj = 1
        else
          adj = 2
        end 
        
        if @mm == 1       #Enero
          i=0; j=0; adj=0 
        elsif @mm == 2    #Febrero
          i=1; j=0; adj=0 
        elsif @mm == 3    #Marzo
          i=1; j=1;
        elsif @mm == 4    #Abril
          i=2; j=1;
        elsif @mm == 5   #Mayo
          i=2; j=2; 
        elsif @mm == 6   #Junio
          i=3; j=2;  
        elsif @mm == 7   #Julio
          i=3; j=3;  
        elsif @mm == 8   #Agosto
          i=4; j=3;  
        elsif @mm == 9   #Septiembre
          i=5; j=3;  
        elsif @mm == 10  #Octubre
          i=5; j=4;  
        elsif @mm == 11  #Noviembre
          i=6; j=4;  
        elsif @mm == 12  #Diciembre
          i=6; j=5;
        end
        
        acum_days = 31*i + 30*j - adj 
          
        w_day = (@dd+acum_days) % 7 + day_start -1
            
        if w_day > 6
          w_day = w_day -7
        end
        puts "day_start: #{day_start}"
        puts "w_day: #{w_day}"
        return w_day
   end
  
end


######################################## APLICACION ########################

class RubyApp_pico_placa < Gtk::Window
 
def initialize
super                                                  #Llama al método inicializador de la clase padre
  inicializar_ventana                                  #Método de aplicación
  @p = "A"                  #Numero de Placa
  @d = "4"                  #Date
  @hh = "2"                 #hour
  @mn = "0"                 #min
  @m = "DATOS NO VALIDOS";  #resultado
end

def inicializar_ventana
  
    set_title "PICO Y PLACA PREDICTOR"                    #Nombre de la ventana
    set_default_size 500, 500                             #Tamaño de la ventana
    
    fixed = Gtk::Fixed.new
    add fixed
    
    #------------CAMPO LICENSE PLATE NUMBER----------------------------
    plate_number = Gtk::Label.new "License plate number (ABC0123)"  #Etiqueta Numero de placa
    fixed.put plate_number, 30, 40                        #Posicion de etiqueta
    add plate_number                                      #añadir    
    p_number = Gtk::Entry.new                             #Entrada para Numero de placa
    fixed.put p_number, 30, 60                            #Posicion de numero de placa  
    p_number.signal_connect "key-release-event" do |w, e| #Manejo de evento para Numero de placa
        #on_key_release w, e, plate_number
        @p = p_number.text 
     end
     
    #----------CAMPO FECHA-------------------------
    date_label = Gtk::Label.new "Date (dd/mm/yyyy)"   #Fecha
    fixed.put date_label, 30, 120                     #Posicion de etiqueta
    add date_label                                    #añadir 
    date = Gtk::Entry.new                             #Entrada para Numero de placa
    fixed.put date, 30, 140                           #Posicion de numero de placa
    date.signal_connect "key-release-event" do |w, e| #Manejo de evento para Numero de placa
        @d = date.text 
     end
    
    
    #--------CAMPO HORA----------------------------
    time_label = Gtk::Label.new "Time (hh:mm), 00:00 - 23:59" # Formato hora
    fixed.put time_label, 30, 200                     #Posicion de etiqueta
    add time_label                                    #añadir 
    time = Gtk::Entry.new                             #Entrada para Numero de placa
    fixed.put time, 30, 220                           #Posicion de numero de placa
    time.signal_connect "key-release-event" do |w, e| #Manejo de evento para Numero de placa
        @hh = time.text 
     end
     
     
     #--------CAMPO MINUTO---------------------------- 
    sep_label = Gtk::Label.new ":"                    #Separador
    fixed.put sep_label, 205, 228                     #Posicion de etiqueta
    min = Gtk::Entry.new                              #Entrada para Numero de placa
    fixed.put min, 220, 220                           #Posicion de numero de placa
    min.signal_connect "key-release-event" do |w, e|  #Manejo de evento para Numero de placa
        @mn = min.text 
     end
    
      
    button = Gtk::Button.new :label =>'Result'
    button.set_size_request 80, 45      
    fixed.put button, 30, 300 
    
    #Evaluacion de los datos
    button.signal_connect "clicked" do
            analisis_pico_placa
            analisis_info
            puts "Hasta pronto: #{@p}"
        end       
   
    button = Gtk::Button.new :label =>'Exit'
    button.signal_connect("clicked") { window.destroy }
    button.set_size_request 80, 45      
    fixed.put button, 300, 300  
    show_all  
end

#---Metodo para mostrar reultado de la evaluacion 
def analisis_info
    md = Gtk::MessageDialog.new :parent => self, 
    :flags => :destroy_with_parent, :type => :info, 
    :buttons_type => :close, :message => @m
    md.run
    md.destroy
 end
 
 #Metodo para analizar los datos ingresados
def analisis_pico_placa
  placa = Plate_Number.new(@p)
  fecha = Date.new(@d)
  hora_p= Time.new(@hh,@mn)
  if placa.validar_plate_number        #Validacion del numero de placa de acuerdo al formato "ABC0123"
    l_n = placa.get_last_plate_number #Se obtiene el ultimo numero de la placa
    if fecha.validar_fecha
      dia = fecha.Week_day
      if hora_p.validar_hora
        h_c=hora_p.get_hora
        #Se verifica si el auto puede circular
        if (h_c > 659 and h_c < 931) or (h_c > 1559 and h_c < 1931) #Se verifica hora
          if dia == 1 #Lunes
            if l_n == 1 or l_n == 2
              @m = "NO habilitado para circular"
            else
              @m = "Habilitado para circular" 
            end
          elsif dia == 2 #Martes
            if l_n == 3 or l_n == 4
              @m = "NO habilitado para circular"
            else
              @m = "Habilitado para circular" 
            end
          elsif dia == 3 #Miercoles
            if l_n == 4 or l_n == 5
              @m = "NO habilitado para circular"
            else
              @m = "Habilitado para circular" 
            end
          elsif dia == 4 #Jueves
            if l_n == 6 or l_n == 7
              @m = "NO habilitado para circular"
            else
              @m = "Habilitado para circular" 
            end
          elsif dia == 5 #Viernes
            if l_n == 8 or l_n == 9
              @m = "NO habilitado para circular"
            else
              @m = "Habilitado para circular" 
            end
          else
            @m = "Habilitado para circular" 
          end
        else 
          @m = "Habilitado para circular" 
        end
        puts "Numero placa: #{l_n}"
        puts "Dia de la semana: #{dia}"
        puts "Hora: #{h_c}"
      else
         @m = "Hora no Valida" 
      end
      
    else 
      @m = "Fecha no Valida"
    end
    
  else
    @m = "Numero de Placa no Valido"
  end
end

end


window = RubyApp_pico_placa.new
Gtk.main
