class UsersController < ApplicationController
  def index
    @users = User.order(:first_name).page params[:page]
    # @users = User.all
    authorize @users
  end

  def new
    @user = User.new
    authorize @user
  end

  def create
    @user = User.new(user_params)
    authorize @user

    if @user.save
      flash[:success] = "New user: #{@user.first_name} has been created."
      redirect_to users_path
    else
      flash[:warning] = "#{@user.errors.full_messages}"
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    
    if @user.update_attributes(user_params)
      flash[:success] = "#{@user.first_name} has been updated."
      redirect_to users_path
    else
      flash[:danger] = "#{@user.errors.full_messages}"
      redirect_to request.referrer || users_path
    end
  end

  def destroy
    @user = User.find(params[:id])
    authorize @user

    if @user.destroy
      flash[:success] = "#{@user.first_name} has been deleted."
      redirect_to request.referrer || users_path
    else
      flash[:danger] = "#{@user.errors.full_messages}"
    end
  end

private

  def user_params
    params.require(:user).permit(:first_name, :middle_name, :last_name, :email, :role, :password, :password_confirmation)
  end
end
