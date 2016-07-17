class DrinkCategoriesController < ApplicationController
  before_filter :check_authentication
  # before_filter :check_authentication, :check_authorization

  PERMITTED_PARAMETERS = [:name, :has_sugar, :has_milk].freeze

  def index
    @drink_categories = DrinkCategory.all

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
        flash[:notice] = 'drink_category was successfully created.'
        format.html { redirect_to(drink_categories_path) }
        # format.xml { render :xml => @drink_category, :status => :created, :location => @drink_category }
      else
        format.html { render :action => "new" }
        # format.xml { render :xml => @drink_category.errors, :status => :unprocessable_entity }
      end
    end
  end


  def show
    @drink_category = DrinkCategory.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      # format.xml  { render xml: @drink_category }
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
        flash[:notice] = 'Drink Category was successfully updated.'
        format.html { redirect_to(drink_categories_path) }
        format.xml  { head :ok }
      else
        format.html { render action: 'edit' }
        format.xml  { render xml: @drink_category.errors, status: :unprocessable_entity }
      end
    end
  end

end
