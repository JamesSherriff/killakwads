class EventsController < ApplicationController
  require 'csv'
  
  before_action :authenticate_user!
  
  def index
    @events = Event.where("finish > ?", Time.now)
  end
  
  def previous
    @events = Event.where("finish < ?", Time.now)
    render :index
  end
  
  def manage
    @event = Event.find(params[:id])
    if cannot? :manage, @event
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  def show
    @event = Event.find(params[:id])
  end
  
  def new
    @event = Event.new
    if cannot? :create, @event
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  def create
    @event = Event.new
    if can? :create, @event
      if @event.update(event_params)
        redirect_to event_path(@event), notice: "Successfully created event."
      else
        render :new
      end
    else
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  def edit
    @event = Event.find(params[:id])
    if cannot? :update, @event
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  def update
    @event = Event.find(params[:id])
    if can? :update, @event
      if @event.update(event_params)
        redirect_to event_path(@event), notice: "Succesfully updated event."
      else
        render :edit
      end
    else
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  def destroy
    @event = Event.find(params[:id])
    if can? :destroy, @event
      if @event.destroy
        redirect_to events_path, notice: "Event deleted."
      else
        redirect_to events_path, notice: "Unable to delete event."
      end
    else
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  def delete_image
    @event = Event.find(params[:id])
    if can? :update, @event
      @event.image.purge
      render :edit
    else
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
    
  def check_channel
    @event = Event.find(params[:event_id])
    registrations = []
    @event.registrations.where(channel: params[:channel_id]).each do |registration|
      registrations << {name: registration.user.name, id: registration.user.id}
    end
    render json: registrations
  end
    
  def registrations
    @event = Event.find(params[:id])
    registrations = @event.registrations
    registrations_csv = CSV.generate(headers: true) do |csv|
      csv << ["email", "name", "channel"]

      registrations.each do |registration|
        csv << [registration.user.email, registration.user.name, "#{registration.channel.band.name} #{registration.channel.name} - #{registration.channel.frequency}"]
      end
    end
    
    respond_to do |format|
      format.csv { send_data registrations_csv, filename: "#{@event.name} - registrations.csv"}
    end
  end
  
  private
  def event_params
    params.require(:event).permit(:name, :description, :location, :start, :finish, :registration_start, :registration_end, :image, :pilot_limit, :stream_id, :pilot_brief, :pilot_brief_downloadable, :channel_allocation_method, channel_ids: [])
  end
end
