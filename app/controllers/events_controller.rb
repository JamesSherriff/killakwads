class EventsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @events = Event.where("finish < ?", Time.now)
  end
  
  def previous
    @events = Event.where("finish > ?", Time.now)
    render :index
  end
  
  def show
    @event = Event.find(params[:id])
  end
  
  def new
    @event = Event.new
  end
  
  def create
    @event = Event.new
    if @event.update(event_params)
      redirect_to event_path(@event), notice: "Successfully created event."
    else
      render :new
    end
  end
  
  def edit
    @event = Event.find(params[:id])
  end
  
  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to event_path(@event), notice: "Succesfully updated event."
    else
      render :edit
    end
  end
  
  def destroy
    @event = Event.find(params[:id])
    if @event.destroy then
      redirect_to events_path, notice: "Event deleted."
    else
      redirect_to events_path, notice: "Unable to delete event."
    end
  end
  
  def delete_image
    @event = Event.find(params[:id])
    @event.image.purge
    render :edit
  end
    
  def check_channel
    @event = Event.find(params[:event_id])
    registrations = []
    @event.registrations.where(channel: params[:channel_id]).each do |registration|
      registrations << {name: registration.user.name, id: registration.user.id}
    end
    render json: registrations
  end
  
  private
  def event_params
    params.require(:event).permit(:name, :description, :location, :start, :finish, :registration_start, :registration_end, :image, :pilot_brief, channel_ids: [])
  end
end
