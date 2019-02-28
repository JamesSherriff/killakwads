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
    if cannot? :create, @user
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  def create
    @user = User.new
    if can? :create, @user
      if @user.update(User_params)
        redirect_to user_path(@user), notice: "Successfully created User."
      else
        render :new
      end
    else
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  def edit
    @user = User.find(params[:id])
    if cannot? :update, @user
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  def update
    @user = User.find(params[:id])
    if can? :update, @user
      if @user.update(user_params)
        redirect_to user_path(@user), notice: "Succesfully updated User."
      else
        render :edit
      end
    else
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    if can? :destroy, @user
      if @user.destroy then
        redirect_to users_path, notice: "User deleted."
      else
        redirect_to users_path, notice: "Unable to delete User."
      end
    else
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  def delete_profile_picture
    @user = User.find(params[:id])
    if can? :update, @user
      @user.profile_picture.purge
      render :edit
    else
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :display_name, :description, :email, :password, :profile_picture)
  end
end
