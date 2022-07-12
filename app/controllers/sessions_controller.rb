class SessionsController < ApplicationController

  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = 'Logged in successfully'
      redirect_to root_path
    else
      unless user.present?
        flash[:danger] = 'email is not registerd'
      else
        flash[:danger] = 'Invalid password'
      end
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'Logged Out successfully'
    redirect_to root_path
  end

end
