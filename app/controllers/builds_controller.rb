class BuildsController < ApplicationController
   before_action :authenticate_user!
  
  def new
    @build = current_user.builds.new
    if cannot? :create, @build
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  def create
    @build = current_user.builds.new
    if can? :create, @build
      if @build.update(build_params)
        redirect_to user_path(current_user), notice: "Build succesfully saved."
      else
        render :new
      end
    else
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  def edit
    @build = Build.find(params[:id])
    if cannot? :update, @build
      redirect_to user_path(current_user), notice: "That's not your build!"
    end
  end
  
  def update
    @build = Build.find(params[:id])
    if can? :update, @build
      if @build.update(build_params)
        redirect_to user_path(current_user), notice: "Build succesfully saved."
      else
        render :edit
      end
    else
      redirect_to user_path(current_user), notice: "That's not your build!"
    end
  end
  
  def destroy
    @build = Build.find(params[:id])
    if !(current_user.admin? || @build.user == current_user)
      if @build.destroy
        redirect_to user_path(current_user), notice: "Succesfully saved build."
      else
        redirect_to user_path(current_user), notice: "Unable to delete build."
      end
    else
      redirect_to user_path(current_user), notice: "That's not your build!"
    end
  end
  
  private
  def build_params
    params.require(:build).permit(:name, :rotorbuilds_url, :image)
  end
end
