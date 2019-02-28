class BandsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @bands = Band.all
    if cannot? :read, Band
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  def new
    @band = Band.new
    if cannot? :create, @band
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  def create
    @band = Band.new
    if can? :update, @band
      if @band.update(band_params)
        redirect_to bands_path, notice: "Saved band"
      else
        render :new
      end
    else
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  def edit
    @band = Band.find(params[:id])
    if cannot? :update, @band
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  def update
    @band = Band.find(params[:id])
    if can? :update, @band
      if @band.update(band_params)
        redirect_to bands_path, notice: "Saved band"
      else
        render :edit
      end
    else
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  def destroy    
    @band = Band.find(params[:id])
    if can? :destroy, @band
      @band.destroy
      redirect_to bands_path, notice: "Band deleted."
    else
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  private
  def band_params
    params.require(:band).permit(:name)
  end
end
