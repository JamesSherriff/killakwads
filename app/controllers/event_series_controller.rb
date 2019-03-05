class EventSeriesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @event_series = EventSeries.all
  end
  
  def new
    @event_series = EventSeries.new
    if cannot? :create, @event_series
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  def create
    @event_series = EventSeries.new
    if can? :create, @event_series
      if @event_series.update(event_series_params)
        redirect_back fallback_url: event_series_path, notice: "Event Series created."
      else
        render :new
      end
    else
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  def edit
    @event_series = EventSeries.find(params[:id])
    if cannot? :create, @event_series
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  def update
    @event_series = EventSeries.find(params[:id])
    if can? :update, @event_series
      if @event_series.update(event_series_params)
        redirect_back fallback_url: event_series_path, notice: "Event Series updated."
      else
        render :edit
      end
    else
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  def show
    @event_series = EventSeries.find(params[:id])
  end
  
  def delete_image
    @event_series = EventSeries.find(params[:id])
    if can? :update, @event_series
      @event_series.image.purge
      render :edit
    else
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  private
  def event_series_params
    params.require(:event_series).permit(:name)
  end
end
