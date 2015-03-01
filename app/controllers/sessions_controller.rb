class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      flash[:notice] = "#{user.username} logged in."
      session[:user_id] = user.id
      redirect_to :root
    else
      flash[:error] = 'There was an error logging in.'
      redirect_to :login
    end
  end

  def destroy
    user = User.find_by(id: session[:user_id])
    flash[:notice] = "#{user.username} logged out."
    session[:user_id] = nil
    redirect_to :root
  end
end