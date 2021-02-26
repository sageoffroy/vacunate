class TableroController < ApplicationController
  before_action :authenticate_user!

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
  	@locality = Locality.where(id: params[:locality]).first
  	@population_group = params[:population_group]
  	@state_string = params[:state]

  	state_aux = @state_string
  	if @state_string == "Nuevo"
  		state_aux = nil
  	end

    if !(@population_group == "Soy mayor de 70 años")
      if @population_group == "Soy personal de educación"
        @population_group = "Soy personal docente/auxiliar"
      end
      @inscripciones = Person.where(locality: @locality, population_group: @population_group, state: state_aux).order(:priority)
    else #Mayor de 70
      @inscripciones = Person.where(locality: @locality, population_group: "Soy mayor de 60 años", state: state_aux, birthdate: 150.years.ago..70.years.ago).order(:priority)
    end



  end

  def update_states
    
    format_dni_list = params[:dni_list].gsub("\r\n", ",")
    dni_list = format_dni_list.split(',')
    @state_string = params[:state]

    params_state = State.where(name: @state_string).first
    new_state = State.where(name: "Nuevo").first

    @log_array = []
    @log_array.push(["Comenzandola actualización", "info"])
    dni_list.each do |dni|

      person = Person.where(dni: dni).first
            
      if person.nil?
        @log_array.push(["El dni: " + dni + " no existe en el registro de inscripciones", "danger"])
      else
        if person.state.nil?
          person.update_state(new_state)
        end

        if person.state == params_state
          @log_array.push(["El dni: " + dni + " ya tenía el estado " + @state_string, "info"])
        else
          person.state = params_state
          person.save
          @log_array.push(["El dni: " + dni + " se actualizó al estado " + @state_string, "success"])
        end
      end
    end

    @log_array.push(["Actualización finalizada", "info"])


    
  end

end

