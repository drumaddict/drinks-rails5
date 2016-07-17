class LineItemsController < ApplicationController
  before_filter :check_authentication
PERMITTED_PARAMETERS = [:order_id, :drink_id,  :sugar, :milk, :quantity ].freeze

  def index
    @line_items = LineItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render json: @line_items }
    end
  end

  def new
    @line_item = LineItem.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render xml: @line_item }
    end
  end

  def create
    @line_item = LineItem.new(permitted_resource_params)
    respond_to do |format|
      if @line_item.save
        flash[:notice] = 'line_item was successfully placed.'
        format.html { redirect_to(@line_item) }
        # format.xml { render :xml => @line_item, :status => :created, :location => @line_item }
      else
        format.html { render :action => "new" }
        # format.xml { render :xml => @line_item.errors, :status => :unprocessable_entity }
      end
    end
  end


  def show
    @line_item = LineItem.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      # format.xml  { render xml: @line_item }
    end
  end


  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy

    respond_to do |format|
      format.html { redirect_to(root_path) }
      format.xml  { head :ok }
    end
  end


  def edit
    @line_item = LineItem.find(params[:id])
  end


  def update
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      if @line_item.update(permitted_resource_params)
        flash[:notice] = 'LineItem was successfully updated.'
        format.html { redirect_to(root_path) }
        format.xml  { head :ok }
      else
        format.html { render action: 'edit' }
        format.xml  { render xml: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

end
