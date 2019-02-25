class RegistrationsController < ApplicationController
  
  def new
    @registration = Registration.new
    if params[:user_id]
      @registration.user = User.find(params[:user_id])
    end
    if params[:event_id]
      @registration.event = Event.find(params[:event_id])
    else
      redirect_to root_path, alert: "You can't register without selecting an event."
    end
    if params[:channel_id]
      @registration.channel = Channel.find(params[:channel_id])
    end
  end
  
  def create
    @registration = Registration.new
    if registration_params[:user_id]
      @registration.user = User.find(registration_params[:user_id])
    end
    if registration_params[:event_id]
      @registration.event = Event.find(registration_params[:event_id])
    else
      redirect_to root_path, alert: "You can't register without selecting an event." and return
    end
    if registration_params[:channel_id]
      @registration.channel = Channel.find(registration_params[:channel_id])
    end
    
    if @registration.update(registration_params)
      if @registration.event && @registration.channel
        @registration.event.registrations.where(channel: @registration.channel).each do |clashing_registration|
          RegistrationsMailer.registration_clash(clashing_registration).deliver_now
        end
      end
      RegistrationsMailer.registration(@registration).deliver_now
      redirect_to event_path(registration_params[:event_id]), notice: "Congratulations! You're registered for this event."
    else
      render :new
    end
  end
  
  def edit
    @registration = Registration.find(params[:id])
    if @registration.user != current_user && current_user.admin?
      flash[:error] = "That's not your registration!"
      redirect_to root_path and return
    end
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  def registration_params
    params.require(:registration).permit(:user_id, :event_id, :channel_id, :notes)
  end
end
