class DrinkCategoriesController < ApplicationController
  before_filter :check_authentication
  before_action :authorize, unless: -> { current_user.manager? }

  PERMITTED_PARAMETERS = [:name, :has_sugar, :has_milk].freeze

  def authorize
    flash[:form_error] = 'Unauthorized.You cannot edit drink categories'
    redirect_to root_path
  end



  def index
    @drink_categories = DrinkCategory.all

    @drink_categories = Kaminari.paginate_array(@drink_categories).page(get_page).per(get_per)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render json: @drink_categories }
    end
  end

  def new
    @drink_category = DrinkCategory.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render xml: @drink_category }
    end
  end


  def create
    @drink_category = DrinkCategory.new(permitted_resource_params)
    respond_to do |format|
      if @drink_category.save
        flash[:success] = 'Drink Category was successfully created.'
        format.html { redirect_to(drink_categories_path) }
      else
        flash.now[:form_error] = 'Please correct the errors'
        format.html { render :action => "new" }
      end
    end
  end


  def show
    @drink_category = DrinkCategory.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
    end
  end


  def destroy
    @drink_category = DrinkCategory.find(params[:id])
    @drink_category.destroy

    respond_to do |format|
      format.html { redirect_to(drink_categories_path) }
      format.xml  { head :ok }
    end
  end


  def edit
    @drink_category = DrinkCategory.find(params[:id])
  end


  def update
    @drink_category = DrinkCategory.find(params[:id])

    respond_to do |format|
      if @drink_category.update(permitted_resource_params)
        flash[:success] = 'Drink Category was successfully updated.'
        format.html { redirect_to(drink_categories_path) }
        format.xml  { head :ok }
      else
        flash[:form_error] = 'Please correct the form errors.'
        format.html { render action: 'edit' }
        format.xml  { render xml: @drink_category.errors, status: :unprocessable_entity }
      end
    end
  end

end
