class KidsController < ApplicationController
  before_action :set_kid, only: [:show, :edit, :update, :destroy]

  def set_co_parent
    set_kid
    #"customer"=>{"fname"=>"wefwef", "email"=>"wefwef"}
    c=Customer.find_by_email(params[:customer][:email])
    unless c
      tokens = params[:customer][:fname].split(' ')
      f = tokens.first
      l = tokens.last
      c=Grownup.create(email: params[:customer][:email],
                        fname: f,
                        lname: l,
                        dob: 18.years.ago)
    end
    @kid.observers.where(flavor: 'co_parent').destroy_all
    @kid.observers.create(observer_id: c.id, kid_id: @kid.id, flavor: 'co_parent')

    redirect_to '/'
  end

  def set_observer
    redirect_to '/'
  end
  
  def index
    @kids = Kid.all
  end

  def show
  end

  def new
    @kid = Kid.new
    @kid.dob = 4.years.ago
    @hide_menu = true
  end

  def edit
  end

  def create
    if current_user
      Kid.add_to(current_user)
      redirect_to '/'
      return
    else
    end

    @kid = Kid.new(kid_params)

    respond_to do |format|
      if @kid.save
        format.html { redirect_to @kid, notice: 'Kid was successfully created.' }
        format.json { render :show, status: :created, location: @kid }
      else
        format.html { render :new }
        format.json { render json: @kid.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /kids/1
  # PATCH/PUT /kids/1.json
  def update
    respond_to do |format|
      if @kid.update(kid_params)
        format.html { redirect_to @kid, notice: 'Kid was successfully updated.' }
        format.json { render :show, status: :ok, location: @kid }
      else
        format.html { render :edit }
        format.json { render json: @kid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kids/1
  # DELETE /kids/1.json
  def destroy
    @kid.destroy
    redirect_to '/'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kid
      @kid = Kid.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kid_params
      params.require(:kid).permit(:fname, :lname, :email, :password, :dob)
    end
end
