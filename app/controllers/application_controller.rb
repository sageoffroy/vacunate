class ApplicationController < ActionController::Base
 	
 	protected
	def authenticate_user!
    	redirect_to root_path, notice: "Debes tener permisos para poder ingresar a esa página" unless user_signed_in?
  	end
end
