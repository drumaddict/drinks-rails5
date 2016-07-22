class OrdersController < ApplicationController
  before_filter :check_authentication
  PERMITTED_PARAMETERS = [:user_id, :status, :favorite, :reoccuring, :comments, line_items_attributes: [:order_id, :drink_category_id, :_destroy,  :drink_id, :sugar, :milk, :quantity]].freeze

  has_scope :favorite, :type => :boolean
  has_scope :reoccuring, :type => :boolean
  has_scope :by_company

  def order_params
    params.require(:order).permit(:user_id, :status, :favorite, :reoccuring,  :hour, :comments,
      line_items_attributes: [:id, :order_id, :drink_category_id,
        :_destroy,  :drink_id, :sugar,
      :milk, :quantity], days: [])
    end


    def milk_sugar_hash
      @id_to_sugar_milk=  DrinkCategory.all.inject({}){|memo,dc| memo[dc.id] = { has_sugar: dc.has_sugar, has_milk: dc.has_milk };memo}.to_json
    end

    def index
      # @orders = Order.al
      # @companies= Company.all
      @orders = apply_scopes(Order).order(id: :desc).all
      respond_to do |format|
        format.html # index.html.erb
        format.json  { render json: @orders }
      end
    end

    def new
      @order = Order.new
      milk_sugar_hash
      1.times {@order.line_items.build}
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render xml: @order }
      end
    end

    def create
      @order = Order.new(order_params)
      respond_to do |format|
        # binding.pry
        @order.line_items.each {|li| li.order=@order}
        if @order.save
          flash[:success] = 'Order was successfully placed.'
          format.html { redirect_to(root_path) }
          # format.xml { render :xml => @order, :status => :created, :location => @order }
        else
          milk_sugar_hash
          flash.now[:form_error] = 'Please correct the errors.'
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
      milk_sugar_hash
      @order = Order.find(params[:id])
    end


    def update
      @order = Order.find(params[:id])

      respond_to do |format|
        # binding.pry
        if @order.update(order_params)
          flash[:success] = 'Order was successfully updated.'
          format.html { redirect_to(root_path) }
          format.xml  { head :ok }
        else
          milk_sugar_hash
          # binding.pry
          flash[:form_error] = 'Please correct the form errors.'
          format.html { render action: 'edit' }

          format.xml  { render xml: @order.errors, status: :unprocessable_entity }
        end
      end
    end
    def reorder
      @order = Order.find(params[:id])
      @reorder = @order.duplicate

      respond_to do |format|
        if @reorder.save
          flash[:success] = 'Your favorite order has been placed again.'
          format.html { redirect_to(root_path) }
          format.xml  { head :ok }
        else
          milk_sugar_hash
          flash[:form_error] = 'Please correct the form errors.'
          format.html { render action: 'edit' }
          format.xml  { render xml: @order.errors, status: :unprocessable_entity }
        end
      end
    end

  end
