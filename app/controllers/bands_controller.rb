class BandsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @bands = Band.all
  end
  
  def new
    @band = Band.new
  end
  
  def create
    @band = Band.new
    if @band.update(band_params)
      redirect_to bands_path, notice: "Saved band"
    else
      render :new
    end
  end
  
  def edit
    @band = Band.find(params[:id])
  end
  
  def update
    @band = Band.find(params[:id])
    if @band.update(band_params)
      redirect_to bands_path, notice: "Saved band"
    else
      render :edit
    end
  end
  
  def destroy    
    @band = Band.find(params[:id])
    @band.destroy
    redirect_to bands_path, notice: "Band deleted."
  end
  
  private
  def band_params
    params.require(:band).permit(:name)
  end
end
