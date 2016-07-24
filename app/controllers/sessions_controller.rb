class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:user][:email])
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(params[:user][:password])
      # Save the user id inside the browser cookie. This is how we keep the user
      # logged in when they navigate around our website.
      session[:user_id] = user.id
      flash[:success] = "Welcome #{user.name} !"
      redirect_to root_path
    else
      flash[:form_error] = "Invalid name or password."
      # If user's login doesn't work, send them back to the login form.
      redirect_to '/login'
    end
  end

  def destroy
    flash[:success] = "Goodbye #{current_user.name} !"
    session[:user_id] = nil
    redirect_to '/login'
  end
end
