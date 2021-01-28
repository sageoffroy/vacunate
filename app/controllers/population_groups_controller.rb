class PopulationGroupsController < ApplicationController
  before_action :set_population_group, only: %i[ show edit update destroy ]

  # GET /population_groups or /population_groups.json
  def index
    @population_groups = PopulationGroup.all
  end

  # GET /population_groups/1 or /population_groups/1.json
  def show
  end

  # GET /population_groups/new
  def new
    @population_group = PopulationGroup.new
  end

  # GET /population_groups/1/edit
  def edit
  end

  # POST /population_groups or /population_groups.json
  def create
    @population_group = PopulationGroup.new(population_group_params)

    respond_to do |format|
      if @population_group.save
        format.html { redirect_to @population_group, notice: "Population group was successfully created." }
        format.json { render :show, status: :created, location: @population_group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @population_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /population_groups/1 or /population_groups/1.json
  def update
    respond_to do |format|
      if @population_group.update(population_group_params)
        format.html { redirect_to @population_group, notice: "Population group was successfully updated." }
        format.json { render :show, status: :ok, location: @population_group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @population_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /population_groups/1 or /population_groups/1.json
  def destroy
    @population_group.destroy
    respond_to do |format|
      format.html { redirect_to population_groups_url, notice: "Population group was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_population_group
      @population_group = PopulationGroup.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def population_group_params
      params.require(:population_group).permit(:code, :priority, :description)
    end
end
