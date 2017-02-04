class GrownupsController < ApplicationController
  before_action :set_grownup, only: [:show, :edit, :update, :destroy]

  # GET /grownups
  # GET /grownups.json
  def index
    @grownups = Grownup.all
  end

  # GET /grownups/1
  # GET /grownups/1.json
  def show
  end

  # GET /grownups/new
  def new
    @parent = Grownup.new
    @kid = Kid.new
  end

  # GET /grownups/1/edit
  def edit
  end

  # POST /grownups
  # POST /grownups.json
  def create
    @grownup = Grownup.new(grownup_params)

    respond_to do |format|
      if @grownup.save
        format.html { redirect_to @grownup, notice: 'Grownup was successfully created.' }
        format.json { render :show, status: :created, location: @grownup }
      else
        format.html { render :new }
        format.json { render json: @grownup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /grownups/1
  # PATCH/PUT /grownups/1.json
  def update
    respond_to do |format|
      if @grownup.update(grownup_params)
        format.html { redirect_to @grownup, notice: 'Grownup was successfully updated.' }
        format.json { render :show, status: :ok, location: @grownup }
      else
        format.html { render :edit }
        format.json { render json: @grownup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grownups/1
  # DELETE /grownups/1.json
  def destroy
    @grownup.destroy
    respond_to do |format|
      format.html { redirect_to grownups_url, notice: 'Grownup was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grownup
      @grownup = Grownup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grownup_params
      params.require(:grownup).permit(:fname, :lname, :email, :password, :admin_level)
    end
end
