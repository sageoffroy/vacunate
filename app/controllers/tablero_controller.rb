class TableroController < ApplicationController
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
  	@total_mayores_60 = inscripciones.where(population_group: "Soy mayor de 60 años").count
  	@total_18_59_riesgo = inscripciones.where(population_group: "Tengo entre 18 y 59 (con factores de riesgo)").count

  	@inscripciones_x_localidad = inscripciones.group(:locality).order('count_id desc').count('id')

		@inscripciones_obesidad = inscripciones.where(obesity: true).count
		@inscripciones_diabetes = inscripciones.where(diabetes: true).count
		@inscripciones_ERC = inscripciones.where(chronic_kidney_disease: true).count
		@inscripciones_EC = inscripciones.where(cardiovascular_disease: true).count
		@inscripciones_EPC = inscripciones.where(chronic_lung_disease: true).count


    if current_user.area == "MS"
      @localities = Locality.all
    else
      @localities = Locality.where(area: Area.where(abbreviation: current_user.area).first)
    end

		count = 0
		inscripciones.all.each do |person|
			if person.have_any_pathology?
				count = count + 1
			end
		end

		@inscripciones_patologia = count

  end

  def list_group_state

    if (params[:locality] == "Todas")
      @locality = Locality.all
    else
      @locality = Locality.where(id: [params[:locality].split(',')])
    end
    
    if (params[:population_group] == "Todos")
      @population_group = ["Soy personal docente/auxiliar", "Soy personal de seguridad", "Soy personal de educación", "Soy mayor de 60 años", "Tengo entre 18 y 59 (con factores de riesgo)", "Tengo entre 18 y 59 (sin factores de riesgo)"]

    else
      @population_group = params[:population_group].split(',')
      if (@population_group.first == "Soy personal de educación")
        @population_group[0] = "Soy personal docente/auxiliar"
      end
    end
    
    @state_string = params[:state].split(',')
    @age_min = params[:age_min].to_i
    params_state = State.where(name:@state_string)
    @inscripciones = Person.where(locality: @locality, population_group: @population_group, state: params_state, birthdate: 150.years.ago..@age_min.years.ago).order(:priority)
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
      @log_array.push(["Comenzandola actualización", "info"])

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

end

