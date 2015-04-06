class SessionsController < ApplicationController
  before_action :require_user, only: [:destroy]


  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      if user.two_factor_auth?
        session[:two_factor] = true
        user.generate_pin!
        user.send_pin_to_twilio!
        # twilio sends pin to user's phone
        redirect_to pin_path
        return
      end

      login_user!(user)
    else
      flash[:error] = 'There was an error logging in.'
      redirect_to :login
    end
  end

  def destroy
    flash[:notice] = "#{current_user.username} logged out."
    session[:user_id] = nil
    redirect_to :root
  end

  def pin
    access_denied if session[:two_factor].nil?
    if request.post?
      user = User.find_by pin: params[:pin]
      if user
        session[:two_factor] = nil
        user.remove_pin!
        login_user!(user)
      else
        flash[:error] = 'Incorrect PIN.'
      end
    end
  end

  private
    def login_user!(user)
      flash[:notice] = "#{user.username} logged in."
      session[:user_id] = user.id
      redirect_to :root
    end
end