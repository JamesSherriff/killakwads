class ChannelsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @channels = Channel.all
  end
  
  def new
    @channel = Channel.new
    if cannot? :create, @channel
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  def create
    @channel = Channel.new
    if can? :create, @channel
      if @channel.update(channel_params)
        redirect_to channels_path, notice: "Saved channel."
      else
        render :new
      end
    else
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  def edit
    @channel = Channel.find(params[:id])
    if cannot? :update, @channel
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  def update
    @channel = Channel.find(params[:id])
    if can? :update, @channel
      if @channel.update(channel_params)
        redirect_to channels_path, notice: "Channel updated."
      else
        render :edit
      end
    else
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  def destroy
    @channel = Channel.find(params[:id])
    if can? :destroy, @channel
      @channel.destroy
      redirect_to channels_path, notice: "Channel deleted."
    else
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  private
  def channel_params
    params.require(:channel).permit(:band_id, :name, :frequency)
  end
end
