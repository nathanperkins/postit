class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:edit, :update]


  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    # pattern, setup 
    @user = User.new(user_params) # created private method to sanitize parameters

    if @user.save
      flash[:notice] = "Your user was created."
      session[:user_id] = @user.id
      redirect_to :root
    else #validation error
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your user was saved."
      redirect_to user_path(@user)
    else #validation error
      render :edit
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation)
      # requires the top level key to be :user
      # permits with bang allows all attributes
      # rails 3 uses attr_accessible in the model
    end

    def set_user
      @user = User.find_by slug: params[:id]
    end

    def require_same_user
      if current_user != @user
        flash[:error] = "You are not allowed to do that."
        redirect_to user_path = @user
      end
    end
end