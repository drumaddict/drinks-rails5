class SessionsController < ApplicationController

  def new
    # render :new, layout: false
  end

    def create
    user = User.find_by_email(params[:user][:email])
    # binding.pry
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(params[:user][:password])
      # Save the user id inside the browser cookie. This is how we keep the user
      # logged in when they navigate around our website.
      session[:user_id] = user.id

      flash.now[:success] = "Welcome #{user.name} !"
      redirect_to root_path
    else
      flash.now[:form_error] = "Wrong credentials."
    # If user's login doesn't work, send them back to the login form.
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end
