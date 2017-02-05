class GrownupsController < ApplicationController
  before_action :set_grownup, only: [:show, :edit, :update, :destroy]

  def login
    redirect_to '/'
  end

  def index
    @grownups = Grownup.all
  end

  def show
  end

  def new
    @parent = Grownup.new
    @kid = Kid.new
    @hide_menu = true
  end

  def edit
  end

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
