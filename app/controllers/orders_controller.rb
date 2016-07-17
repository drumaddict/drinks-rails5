class OrdersController < ApplicationController
  before_filter :check_authentication
PERMITTED_PARAMETERS = [:user_id, :status, :favorite, :reoccuring, :comments, line_items_attributes: [:order_id, :drink_id, :sugar, :milk, :quantity]].freeze



  def index
    @orders = Order.all

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render json: @orders }
    end
  end

  def new
    @order = Order.new
    1.times {@order.line_items.build}
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render xml: @order }
    end
  end

  def create
    @order = Order.new(permitted_resource_params)
    respond_to do |format|
      if @order.save
        flash[:notice] = 'order was successfully placed.'
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


  def edit
    @order = Order.find(params[:id])
  end


  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update(permitted_resource_params)
        flash[:notice] = 'Order was successfully updated.'
        format.html { redirect_to(root_path) }
        format.xml  { head :ok }
      else
        format.html { render action: 'edit' }
        format.xml  { render xml: @order.errors, status: :unprocessable_entity }
      end
    end
  end

end
