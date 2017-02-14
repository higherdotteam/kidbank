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
    #"grownup"=>{"fname"=>"wefefw", "lname"=>"wfwef", "email"=>"wefwef", "dob(1i)"=>"1999", "dob(2i)"=>"2", "dob(3i)"=>"5"}
    c = Customer.find_by_email(params[:grownup][:email])
    if c
      flash[:notice] = 'Please just login with that email.'
      redirect_to '/sessions/new'
      return
    end

    flp = params[:grownup][:fname] #first last parent
    ptokens = flp.split(' ')
    flk = params[:grownup][:lname] #first last kid
    ktokens = flk.split(' ')

    c = Customer.create(fname: ptokens.first, lname: ptokens[1..-1].join(' '), email: params[:grownup][:email], dob: 18.years.ago)

    etokens = c.email.split('@')
    momdadplus = "#{etokens.first}+#{rand(999999999999)}@#{etokens.last}"

    dob=Date.parse(params[:grownup]['dob(1i)']+'-'+ params[:grownup]['dob(2i)'] + '-'+ params[:grownup]['dob(3i)'])
    kid=Kid.create(email: momdadplus, dob: dob, fname: ktokens.first, lname: ktokens[1..-1].join(' '))
    KidGrownup.create(kid_id: kid.id, grownup_id: c.id)

    session[:person_id] = c.id
    redirect_to '/'
  rescue
    flash[:notice] = 'Please check what you entered and try again.'
    redirect_to '/grownups/new'
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
