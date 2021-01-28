class InscripcionController < ApplicationController
 	skip_before_action :verify_authenticity_token, raise: false
  	skip_after_action :verify_authorized
  	
  	def index
  		@person = Person.new
  	end
end
