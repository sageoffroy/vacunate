class TableroController < ApplicationController
  before_action :authenticate_user!
  
  def index
  	@total_de_inscripciones = Person.all.count
  	@total_mayores_60 = Person.where(population_group: "Soy mayor de 60 años").count
  	@total_18_59_riesgo = Person.where(population_group: "Tengo entre 18 y 59 (con factores de riesgo)").count

  	@inscripciones_x_localidad = Person.group(:locality).order('count_id desc').count('id')


  	@inscripciones_x_localidad = Person.group(:locality).order('count_id desc').count('id')

	@inscripciones_obesidad = Person.where(obesity: true).count
	@inscripciones_diabetes = Person.where(diabetes: true).count
	@inscripciones_ERC = Person.where(chronic_kidney_disease: true).count
	@inscripciones_EC = Person.where(cardiovascular_disease: true).count
	@inscripciones_EPC = Person.where(chronic_lung_disease: true).count
	

	count = 0
	Person.all.each do |person|
		if person.have_any_pathology?
			count = count + 1 
		end
	end

	@inscripciones_patologia = count

  end
end
