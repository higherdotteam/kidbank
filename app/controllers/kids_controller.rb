class KidsController < ApplicationController
  before_action :set_kid, only: [:show, :edit, :update, :destroy]

  def bump_level
    set_kid
    Kid.increment_counter(:level, @kid.id)
    redirect_to '/'
  end

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

  def login_as
    set_kid
    session[:person_id] = @kid.id
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
    dob=Date.parse(params[:kid]['dob(1i)']+'-'+ params[:kid]['dob(2i)'] + '-'+ params[:kid]['dob(3i)'])

    if current_user
      etokens = current_user.email.split('@')
      momdadplus = "#{etokens.first}+#{rand(999999999999)}@#{etokens.last}"
      Kid.add_to(current_user, momdadplus, dob, params[:kid][:fname], params[:kid][:lname])
      redirect_to '/'
      return
    else
      # kid"=>{"fname"=>"bobby", "lname"=>"smith", "email"=>"break@dance.com", "dob(1i)"=>"2003", "dob(2i)"=>"2", "dob(3i)"=>"5"
      c = Customer.find_by_email(params[:kid][:email])
      if c
        flash[:notice] = 'Email already in system, your mom or dad* can login and give you your password.'
        redirect_to '/sessions/new'
        return
      end

      c=Grownup.create(email: params[:kid][:email], dob: 18.years.ago)

      etokens = params[:kid][:email].split('@')
      momdadplus = "#{etokens.first}+#{rand(999999999999)}@#{etokens.last}"

      kid=Kid.create(email: momdadplus, dob: dob, fname: params[:kid][:fname], lname: params[:kid][:lname])
      KidGrownup.create(kid_id: kid.id, grownup_id: c.id)

      session[:person_id] = kid.id
      redirect_to '/'
      return
    end
  end

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

  def destroy
    @kid.destroy
    redirect_to '/'
  end

  private
    def set_kid
      @kid = Kid.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kid_params
      params.require(:kid).permit(:fname, :lname, :email, :password, :dob)
    end
end
