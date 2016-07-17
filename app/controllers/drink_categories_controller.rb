
class DrinkCategoryController < ApplicationController
before_filter :check_authentication, :check_authorization
def new
  @drink_category = DrinkCategory.new
  respond_to do |format|
    format.html # new.html.erb
    format.xml  { render xml: @drink_category }
  end
  end
def create
  @drink_category = DrinkCategory.new(params[:drink_category])
  respond_to do |format|
    if @drink_category.save
      flash[:notice] = 'drink_category was successfully created.'
      format.html { redirect_to(@drink_category) }
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
    format.html { redirect_to(root_path) }
    format.xml  { head :ok }
  end
end



end
