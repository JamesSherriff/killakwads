class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = User.all
  end


  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new
    if !current_user.admin?
      redirect_to root_path, notice: "You need to be an admin to do that." and return
    end
    if @user.update(User_params)
      redirect_to user_path(@user), notice: "Successfully created User."
    else
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
    if !(current_user.admin? || @user == current_user)
      redirect_to root_path, notice: "You need to be an admin to do that." and return
    end
  end
  
  def update
    @user = User.find(params[:id])
    if !(current_user.admin? || @user == current_user)
      redirect_to root_path, notice: "You need to be an admin to do that." and return
    end
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "Succesfully updated User."
    else
      render :edit
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    if !(current_user.admin? || @user == current_user)
      redirect_to root_path, notice: "You need to be an admin to do that." and return
    end
    if @user.destroy then
      redirect_to users_path, notice: "User deleted."
    else
      redirect_to users_path, notice: "Unable to delete User."
    end
  end
  
  def delete_profile_picture
    @user = User.find(params[:id])
    if !(current_user.admin? || @user == current_user)
      redirect_to root_path, notice: "You need to be an admin to do that." and return
    end
    @user.profile_picture.purge
    render :edit
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :display_name, :description, :email, :password, :profile_picture)
  end
end
