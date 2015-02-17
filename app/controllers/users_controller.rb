class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find params[:id]
  end

  def new
    @user = User.new
  end

  def create
    # pattern, setup 
    @user = User.new(user_params) # created private method to sanitize parameters

    if @user.save
      flash[:notice] = "Your user was created."
      redirect_to user_path(@user)
    else #validation error
      render :new
    end
  end

  private

    def user_params
      params.require(:user).permit(:username)
      # requires the top level key to be :user
      # permits with bang allows all attributes
      # rails 3 uses attr_accessible in the model
    end

    def set_user
      @user = User.find params[:id]
    end
end