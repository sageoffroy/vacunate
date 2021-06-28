class TableroController < ApplicationController
  require "csv"
  before_action :authenticate_user!, :except => [:check_dni]


  def index

    if !current_user.nil?
  		if current_user.area == "dpapt"
        inscripciones = Person.where(locality: Locality.where(area: 1))
  		elsif current_user.area == "dpapn"
  			inscripciones = Person.where(locality: Locality.where(area: 2))
  		elsif current_user.area == "dpape"
  			inscripciones = Person.where(locality: Locality.where(area: 3))
  		elsif current_user.area == "dpapcr"
  			inscripciones = Person.where(locality: Locality.where(area: 4))
  		else
  			inscripciones = Person.all
  		end
  	end


  	@total_de_inscripciones = inscripciones.count
    @total_nuevos = inscripciones.where(state:1).count
    @total_de_vacunados = inscripciones.where(state:2).count
    @total_ausentes = inscripciones.where(state:3).count
    #---------------------------------------------------------------


    #@total_mayores_70 = inscripciones.where(population_group: "Soy mayor de 60 años", birthdate: (150.years.ago - 1.day)..70.year.ago).count
    #@total_mayores_60 = inscripciones.where(population_group: "Soy mayor de 60 años", birthdate: (70.years.ago - 1.day)..60.year.ago).count
    @total_mayores_60 = inscripciones.where(population_group: "Soy mayor de 60 años").count
  	@total_18_59_con_riesgo = inscripciones.where(population_group: "Tengo entre 18 y 59 (con factores de riesgo)").count
    @total_18_59_sin_riesgo = inscripciones.where(population_group: "Tengo entre 18 y 59 (sin factores de riesgo)").count
    @total_educacion = inscripciones.where(population_group: "Soy personal docente/auxiliar").count
    @total_seguridad = inscripciones.where(population_group: "Soy personal de seguridad").count
    @total_salud = inscripciones.where(population_group: "Soy personal de salud").count

    a = inscripciones.group(:locality).order('count_id desc').count('id')
    @inscripciones_x_localidad = p Hash[*a.sort_by { |k,v| -v }[0..5].flatten]

    v = inscripciones.group(:locality).where(state:1).order('count_id desc').count('id')
    @inscripciones_x_localidad_vacunado = p Hash[*v.sort_by { |k,v| -v }[0..5].flatten]


    #@inscripciones_x_localidad_nuevo = inscripciones.group(:locality).where(state:1).order('count_id desc').count('id')
    #@inscripciones_x_localidad_vacunado = inscripciones.group(:locality).where(state:2).order('count_id desc').count('id')

    

		if current_user.area == "MS"
      @localities = Locality.all
    else
      @localities = Locality.where(area: Area.where(abbreviation: current_user.area).first)
    end

#   count = 0
#		inscripciones.all.each do |person|
#			if person.have_any_pathology?
#				count = count + 1
#			end
#		end

#		@inscripciones_patologia = count

  end

  def list_group_state

    if !current_user.nil?
  		if current_user.area == "dpapt"
        inscripciones_area = Person.where(locality: Locality.where(area: 1))
  		elsif current_user.area == "dpapn"
  			inscripciones_area = Person.where(locality: Locality.where(area: 2))
  		elsif current_user.area == "dpape"
  			inscripciones_area = Person.where(locality: Locality.where(area: 3))
  		elsif current_user.area == "dpapcr"
  			inscripciones_area = Person.where(locality: Locality.where(area: 4))
  		else
  			inscripciones_area = Person.all
  		end
  	end


    locality_filter = true
    if (params[:locality] == "Todas")
      #@locality = Locality.all
      if current_user.area == "MS"
        @localities = Locality.all
      else
        @localities = Locality.where(area: Area.where(abbreviation: current_user.area).first)
      end
    else
      @localities = Locality.where(id: [params[:locality].split(',')])
    end

    population_group_filter = true
    if (params[:population_group] == "Todos")
      population_group_filter = false
      #@population_group = ["Soy personal docente/auxiliar", "Soy personal de seguridad", "Soy personal de salud", "Soy mayor de 60 años", "Tengo entre 18 y 59 (con factores de riesgo)", "Tengo entre 18 y 59 (sin factores de riesgo)"]

    else
      @population_group = params[:population_group].split(',')
      if (@population_group.first == "Soy personal de educación")
        @population_group[0] = "Soy personal docente/auxiliar"
      end
    end

    @state_string = params[:state].split(',')
    @age_min = params[:age_min].to_i
    params_state = State.where(name:@state_string)

    if locality_filter
      if population_group_filter
        @inscripciones = Person.where(locality: @localities, population_group: @population_group, state: params_state).includes(:locality, :state)
      else
        @inscripciones = Person.where(locality: @localities, state: params_state).includes(:locality, :state)
      end
    else
      if population_group_filter
        @inscripciones = Person.where(population_group: @population_group, state: params_state).includes(:locality, :state)
      else
        @inscripciones = Person.where(state: params_state).includes(:locality, :state)
      end
    end
  end

  def change_state
    @state_string = params[:state]
    state = State.where(name: @state_string).first
    person = Person.where(id: params[:id]).first
    person.update_state(state)

    respond_to do |format|
      format.js
    end
  end

  def check_dni
    @dni = params[:dni]
    dni_number = @dni.to_i
    if dni_number > 99999
      @person = Person.where(dni:dni_number).first
    end
    respond_to do |format|
      format.js
    end
  end

  def update_states
    format_dni_list = params[:dni_list].gsub("\r\n", ",")
    dni_list = format_dni_list.split(',')
    @state_string = params[:state]
    @log_array = []
    @log_array.push(["Comenzando la modificación de estados", "info"])
    params_state = State.where(name: @state_string).first
    if !params_state.nil?
      new_state = State.where(name: "Nuevo").first
      dni_list.each do |dni|
        person = Person.where(dni: dni).first

        #Si la persona no éxiste
        if person.nil?
          @log_array.push(["El dni: " + dni + " no existe en el registro de inscripciones", "danger"])
        else
          #Si la persona no tiene un estado asociado, le asignamos el estado nuevo
          if person.state.nil?
            person.update_state(new_state)
          end

          #Si la persona ya tiene ese estado
          if person.state == params_state
            @log_array.push(["El dni: " + dni + " ya tenía el estado " + @state_string, "info"])
          else
            person.update_state(params_state)
            @log_array.push(["El dni: " + dni + " se actualizó al estado " + @state_string, "success"])
          end
        end
      end
    else
      @log_array.push(["El estado: " + @state_string + " no es un estado válido", "danger"])
    end

    @log_array.push(["Actualización finalizada", "info"])
  end

  def update_ages

    @log_array = []
    @log_array.push(["Comenzando la actualización de edades.", "info"])

    locality = Locality.where(id: [params[:locality].split(',')])


    if locality.nil?
      @log_array.push(["Debe elegir al menos una localidad.", "error"])
    else

      @people = Person.where(state:1, locality: locality)

      @people.each do |person|
        if person.age < 5 or person.age > 110
          @log_array.push([person.population_group + " - El dni: " + person.dni.to_s + " percibe una edad errona: " + person.age.to_s + " ( " +person.birthdate.to_s + " )" , "error"])

          day = person.birthdate.day
          month = person.birthdate.month
          age = person.birthdate.year
          type = "info"

          if person.population_group === "Soy mayor de 60 años"
            age = 1960
            if person.birthdate.year.to_s.size == 4
              age_aux = ("19"+ person.birthdate.year.to_s[2..4]).to_i
              if age.between? 1900, 1960
                age = age_aux
                type = "success"
              end
            elsif person.birthdate.year.to_s.size > 4
              age_aux = person.birthdate.year.to_s[0..3].to_i
              if age.between? 1900, 1960
                age = age_aux
                type = "success"
              end
            end

          else
            age = 2003
            if person.birthdate.year.to_s.size == 4
              age_aux = ("19"+ person.birthdate.year.to_s[2..4]).to_i
              if age.between? 1961, 2004
                age = age_aux
                type = "success"
              end
            elsif person.birthdate.year.to_s.size > 4
              age_aux = person.birthdate.year.to_s[0..3].to_i
              if age.between? 1961, 2004
                age = age_aux
                type = "success"
              end
            end
          end
          person.update_birthdate(Date.new(age, month, day))
          @log_array.push(["Se actualizó la edad a: " + person.age.to_s + " ( " +person.birthdate.to_s + " - Prioridad: " + person.priority.to_s + " )" , type])
        end
      end
    end
  end

  def create_csv

    if !current_user.nil?
      if current_user.area == "dpapt"
        inscripciones = Person.where(locality: Locality.where(area: 1))
      elsif current_user.area == "dpapn"
        inscripciones = Person.where(locality: Locality.where(area: 2))
      elsif current_user.area == "dpape"
        inscripciones = Person.where(locality: Locality.where(area: 3))
      elsif current_user.area == "dpapcr"
        inscripciones = Person.where(locality: Locality.where(area: 4))
      else
        inscripciones = Person.all
      end


      File.open("#{Rails.root}/public/inscripciones"+current_user.area+".csv", "wb") do |f|
        f.write "Fecha: " +   Time.now.strftime("%d/%m/%Y") + "\n"
        Person.copy_to do |line|
          f.write line
        end
      end


    end
  end

  def change_csv_to_tab
    csv_aux = File.read("#{Rails.root}/public/inscripciones"+current_user.area+".csv")
    changed_data = csv_aux.gsub(",", "\t")
    File.open("#{Rails.root}/public/inscripciones"+current_user.area+".csv", "wb") do |f|
      f.write(changed_data)
    end
  end

  def change_csv_to_semicolon
    csv_aux = File.read("#{Rails.root}/public/inscripciones"+current_user.area+".csv")
    changed_data = csv_aux.gsub(",", ";")
    File.open("#{Rails.root}/public/inscripciones"+current_user.area+".csv", "wb") do |f|
      f.write(changed_data)
    end
  end

  def download_tab
    change_csv_to_tab
    send_file "#{Rails.root}/public/inscripciones"+current_user.area+".csv", type: "application/csv", x_sendfile: true
  end

  def download_semicolon
    change_csv_to_semicolon
    send_file "#{Rails.root}/public/inscripciones"+current_user.area+".csv", type: "application/csv", x_sendfile: true
  end
end
