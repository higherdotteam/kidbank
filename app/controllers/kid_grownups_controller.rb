class KidGrownupsController < ApplicationController
  before_action :set_kid_grownup, only: [:show, :edit, :update, :destroy]

  # GET /kid_grownups
  # GET /kid_grownups.json
  def index
    @kid_grownups = KidGrownup.all
  end

  # GET /kid_grownups/1
  # GET /kid_grownups/1.json
  def show
  end

  # GET /kid_grownups/new
  def new
    @kid_grownup = KidGrownup.new
  end

  # GET /kid_grownups/1/edit
  def edit
  end

  # POST /kid_grownups
  # POST /kid_grownups.json
  def create
    @kid_grownup = KidGrownup.new(kid_grownup_params)

    respond_to do |format|
      if @kid_grownup.save
        format.html { redirect_to @kid_grownup, notice: 'Kid grownup was successfully created.' }
        format.json { render :show, status: :created, location: @kid_grownup }
      else
        format.html { render :new }
        format.json { render json: @kid_grownup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /kid_grownups/1
  # PATCH/PUT /kid_grownups/1.json
  def update
    respond_to do |format|
      if @kid_grownup.update(kid_grownup_params)
        format.html { redirect_to @kid_grownup, notice: 'Kid grownup was successfully updated.' }
        format.json { render :show, status: :ok, location: @kid_grownup }
      else
        format.html { render :edit }
        format.json { render json: @kid_grownup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kid_grownups/1
  # DELETE /kid_grownups/1.json
  def destroy
    @kid_grownup.destroy
    respond_to do |format|
      format.html { redirect_to kid_grownups_url, notice: 'Kid grownup was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kid_grownup
      @kid_grownup = KidGrownup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kid_grownup_params
      params.require(:kid_grownup).permit(:kid_id, :grownup_id)
    end
end
