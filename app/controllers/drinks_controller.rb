class DrinksController < ApplicationController
# before_filter :check_authentication, :check_authorization
before_filter :check_authentication


  PERMITTED_PARAMETERS = [:name, :drink_category_id].freeze
def index
  @drinks = Drink.all

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
      flash[:notice] = 'drink was successfully created.'
      format.html { redirect_to(drinks_path) }
      # format.xml { render :xml => @drink, :status => :created, :location => @drink }
    else
      format.html { render :action => "new" }
      # format.xml { render :xml => @drink.errors, :status => :unprocessable_entity }
    end
  end
end


def show
  @drink = Drink.find(params[:id])
  respond_to do |format|
    format.html # show.html.erb
    # format.xml  { render xml: @drink }
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
      flash[:notice] = 'Drink was successfully updated.'
      format.html { redirect_to(drinks_path) }
      format.xml  { head :ok }
    else
      format.html { render action: 'edit' }
      format.xml  { render xml: @drink.errors, status: :unprocessable_entity }
    end
  end
end

end
