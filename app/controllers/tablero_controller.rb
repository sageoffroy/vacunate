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
  	@state = params[:state]

  	state_aux = @state
  	if @state == "Nuevo"
  		state_aux = nil
  	end

    if !@population_group == "Soy mayor de 70 años"
      @inscripciones = Person.where(locality: @locality, population_group: @population_group, state: state_aux)
    else
      @inscripciones = Person.where(locality: @locality, population_group: "Soy mayor de 60 años", state: state_aux)
    end



  end

end
