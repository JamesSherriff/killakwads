class UsersController < ApplicationController
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
    if @user.update(User_params)
      redirect_to User_path(@user), notice: "Successfully created User."
    else
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(User_params)
      redirect_to User_path(@user), notice: "Succesfully updated User."
    else
      render :edit
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    if @user.destroy then
      redirect_to Users_path, notice: "User deleted."
    else
      redirect_to Users_path, notice: "Unable to delete User."
    end
  end
  
  def delete_image
    @user = User.find(params[:id])
    @user.image.purge
    render :edit
  end
    
  def check_channel
  end
  
  private
  def User_params
    params.require(:user).permit(:name, :description, :location, :email, :password, :display_name, :image, :pilot_brief)
  end
end
