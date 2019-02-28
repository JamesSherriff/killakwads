class ResultSetsController < ApplicationController
  before_action :authenticate_user!
  
  def new    
    @event = Event.find(params[:event_id])
    @result_set = @event.result_sets.new
    if cannot? :create, @result_set
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  def create
    @event = Event.find(params[:event_id])
    @result_set = @event.result_sets.new
    if can? :create, @result_set
      if @result_set.update(result_set_params)
        redirect_to manage_event_path(@event, section: "results"), notice: "Result set saved."
      else
        render :new
      end
    else
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  def edit
    @result_set = ResultSet.find(params[:id])
    @event = @result_set.event
  end
  
  def update
    @result_set = ResultSet.find(params[:id])
    if can? :update, @result_set
      if @result_set.update(result_set_params)
        redirect_to manage_event_path(@result_set.event, section: "results"), notice: "Result set saved."
      else
        render :edit
      end
    else
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  def destroy
    @result_set = ResultSet.find(params[:id])
    @event = @result_set.event
    if can? :destroy, @result_set
      if @result_set.destroy
        redirect_to manage_event_path(@event, section: "results"), notice: "Result set deleted."
      else
        redirect_to manage_event_path(@event, section: "results"), notice: "Unable to delete result set."
      end
    else
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  private
  def result_set_params
    params.require(:result_set).permit(:name, :result_type, :event_id)
  end
end
