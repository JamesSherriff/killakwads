class ChannelsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @channels = Channel.all
  end
  
  def new
    @channel = Channel.new
  end
  
  def create
    @channel = Channel.new
    if @channel.update(channel_params)
      redirect_to channels_path, notice: "Saved channel."
    else
      render :new
    end
  end
  
  def edit
    @channel = Channel.find(params[:id])
  end
  
  def update
    @channel = Channel.find(params[:id])
    if @channel.update(channel_params)
      redirect_to channels_path, notice: "Channel updated."
    else
      render :edit
    end
  end
  
  def destroy
    @channel = Channel.find(params[:id])
    @channel.destroy
    redirect_to channels_path, notice: "Channel deleted."
  end
  
  private
  def channel_params
    params.require(:channel).permit(:band_id, :name, :frequency)
  end
end
