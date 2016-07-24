class DrinksController < ApplicationController
  before_filter :check_authentication
  before_action :authorize, unless: -> { current_user.manager? }

  PERMITTED_PARAMETERS = [:name, :drink_category_id].freeze

  def authorize
    flash[:form_error] = 'Unauthorized.You cannot edit drinks'
    redirect_to root_path
  end

  def index
    @drinks =  params[:cat_id].present? ? Drink.where(drink_category_id: params[:cat_id].to_i) : Drink.all
    @paginated_drinks = Kaminari.paginate_array(@drinks).page(get_page).per(get_per)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render json: @drinks }
    end
  end


  def new
    @drink = Drink.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render xml: @drink }
    end
  end

  def create
    @drink = Drink.new(permitted_resource_params)
    respond_to do |format|
      if @drink.save
        flash[:success] = 'Drink was successfully created.'
        format.html { redirect_to(drinks_path) }
      else
        flash.now[:form_error] = 'Please correct the errors'
        format.html { render :action => "new" }
      end
    end
  end


  def show
    @drink = Drink.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
    end
  end


  def destroy
    @drink = Drink.find(params[:id])
    @drink.destroy

    respond_to do |format|
      format.html { redirect_to(root_path) }
      format.xml  { head :ok }
    end
  end

  def edit
    @drink = Drink.find(params[:id])
  end


  def update
    @drink = Drink.find(params[:id])
    respond_to do |format|
      if @drink.update(permitted_resource_params)
        flash[:success] = 'Drink was successfully updated.'
        format.html { redirect_to(drinks_path) }
        format.xml  { head :ok }
      else
        flash[:form_error] = 'Please correct the form errors.'
        format.html { render action: 'edit' }
        format.xml  { render xml: @drink.errors, status: :unprocessable_entity }
      end
    end
  end

end
