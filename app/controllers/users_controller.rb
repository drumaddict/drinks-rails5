# app/controllers/users_controller.rb

class UsersController < ApplicationController
PERMITTED_PARAMETERS = [:name,:company_id].freeze

    def new
    end

    def create
    end
    def edit
      @user = User.find(current_user.id)
    end

   def update
     @user = User.find(params[:id])

     respond_to do |format|
       if @user.update(permitted_resource_params)
         flash[:success] = "User #{current_user.name} was successfully updated."
         format.html { redirect_to(root_path) }
         format.xml  { head :ok }
       else

         flash[:form_error] = 'Please correct the form errors'
         format.html { render action: 'edit' }
         format.xml  { render xml: @user.errors, status: :unprocessable_entity }
       end
     end
   end

end
