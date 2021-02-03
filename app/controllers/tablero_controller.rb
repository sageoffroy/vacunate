class TableroController < ApplicationController
  def index
  	@total_de_inscripciones = Person.all.count
  	@total_mayores_60 = Person.where(population_group: "Soy mayor de 60 años").count
  	@total_18_59_riesgo = Person.where(population_group: "Tengo entre 18 y 59 (con factores de riesgo)").count

  	@inscripciones_x_localidad = Person.group(:locality).order('count_id desc').count('id')

  	

  end
end
