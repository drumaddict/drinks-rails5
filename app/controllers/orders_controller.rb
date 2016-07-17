class OrdersController < ApplicationController

before_filter :check_authentication
def new
  @order = Order.new
  respond_to do |format|
    format.html # new.html.erb
    format.xml  { render xml: @order }
  end
end

def create
  @order = order.new(params[:order])
  respond_to do |format|
    if @order.save
      flash[:notice] = 'order was successfully created.'
      format.html { redirect_to(@order) }
      # format.xml { render :xml => @order, :status => :created, :location => @order }
    else
      format.html { render :action => "new" }
      # format.xml { render :xml => @order.errors, :status => :unprocessable_entity }
    end
  end
end


def show
  @order = Order.find(params[:id])
  respond_to do |format|
    format.html # show.html.erb
    # format.xml  { render xml: @order }
  end
end


def destroy
  @order = Order.find(params[:id])
  @order.destroy

  respond_to do |format|
    format.html { redirect_to(root_path) }
    format.xml  { head :ok }
  end
end



end
