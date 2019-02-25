class BuildsController < ApplicationController
   before_action :authenticate_user!
  
  def new
    @build = current_user.builds.new
  end
  
  def create
    @build = current_user.builds.new
    if @build.update(build_params)
      redirect_to user_path(current_user), notice: "Build succesfully saved."
    else
      render :new
    end
  end
  
  def edit
    @build = Build.find(params[:id])
    if !(current_user.admin? || @build.user == current_user)
      redirect_to user_path(current_user), notice: "That's not your build!" and return
    end
  end
  
  def update
    @build = Build.find(params[:id])
    if !(current_user.admin? || @build.user == current_user)
      redirect_to user_path(current_user), notice: "That's not your build!" and return
    end
    if @build.update(build_params)
      redirect_to user_path(current_user), notice: "Build succesfully saved."
    else
      render :edit
    end
  end
  
  def destroy
    @build = Build.find(params[:id])
    if !(current_user.admin? || @build.user == current_user)
      redirect_to user_path(current_user), notice: "That's not your build!" and return
    end
    if @build.destroy
      redirect_to user_path(current_user), notice: "Succesfully saved build."
    else
      redirect_to user_path(current_user), notice: "Unable to delete build."
    end
  end
  
  private
  def build_params
    params.require(:build).permit(:name, :rotorbuilds_url, :image)
  end
end
