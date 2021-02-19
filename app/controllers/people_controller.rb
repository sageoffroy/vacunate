class PeopleController < ApplicationController
  before_action :set_person, only: %i[ show edit update destroy ]

  before_action :authenticate_user!, :only => [:index, :edit]


  # GET /people or /people.json
  def index
    respond_to do |format|
      format.html
      format.json { render json: PersonDatatable.new(params, view_context: view_context) }
    end
  end

  # GET /people/1 or /people/1.json
  def show
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  def felicitaciones
    
  end

  def priority
    
  end
  # GET /people/1/edit
  def edit
  end

  # POST /people or /people.json
  def create
    @person = Person.new(person_params)
    respond_to do |format|
      if verify_recaptcha(model: @person, attribute: "recaptcha", message:"Debes verificar que no eres un robot") && @person.save
        format.html { redirect_to @person}
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new}
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  

  # PATCH/PUT /people/1 or /people/1.json
  def update
    authorize! :update, Person, :message => "No tienes permisos para actulizar esta inscripción."

    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, notice: "Person was successfully updated." }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1 or /people/1.json
  def destroy
    
    authorize! :destroy, Person, :message => "No tienes permisos para destruir inscripciones."

    @person.destroy

    respond_to do |format|
      format.html { redirect_to people_url, notice: "La inscripción a sido destruida." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def person_params
      params.require(:person).permit(:firstname, :lastname, :dni, :dni_sex, :self_perceived_sex, :birthdate, :phone_code, :phone, :email, :condition, :population_group, :locality_id, :address_street, :address_number, :address_floor, :address_department, :state_id, :obesity, :diabetes, :chronic_kidney_disease, :cardiovascular_disease, :chronic_lung_disease)
    end

    def validate_params
      params.permit(:firstname, :lastname, :dni, :from, :to)
    end
end
