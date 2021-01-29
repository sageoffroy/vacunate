class PathologiesController < ApplicationController
  before_action :set_pathology, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /pathologies or /pathologies.json
  def index
    @pathologies = Pathology.all
  end

  # GET /pathologies/1 or /pathologies/1.json
  def show
  end

  # GET /pathologies/new
  def new
    @pathology = Pathology.new
  end

  # GET /pathologies/1/edit
  def edit
  end

  # POST /pathologies or /pathologies.json
  def create
    @pathology = Pathology.new(pathology_params)

    respond_to do |format|
      if @pathology.save
        format.html { redirect_to @pathology, notice: "Pathology was successfully created." }
        format.json { render :show, status: :created, location: @pathology }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @pathology.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pathologies/1 or /pathologies/1.json
  def update
    respond_to do |format|
      if @pathology.update(pathology_params)
        format.html { redirect_to @pathology, notice: "Pathology was successfully updated." }
        format.json { render :show, status: :ok, location: @pathology }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pathology.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pathologies/1 or /pathologies/1.json
  def destroy
    @pathology.destroy
    respond_to do |format|
      format.html { redirect_to pathologies_url, notice: "Pathology was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pathology
      @pathology = Pathology.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pathology_params
      params.require(:pathology).permit(:code, :priority, :description)
    end
end
