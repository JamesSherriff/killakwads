class ResultsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @result_set = ResultSet.find(params[:result_set_id])
    @result = @result_set.results.new
    if cannot? :create, @result
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  def create
    @result_set = ResultSet.find(params[:result_set_id])
    @result = @result_set.results.new
    if can? :create, @result
      if @result.update(result_params)
        redirect_to manage_event_path(@result_set.event, section: "results"), notice: "Saved result."
      else
        render :new
      end
    else
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  def edit
    @result = Result.find(params[:id])
    if cannot? :update, @result
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  def update
    @result = Result.find(params[:id])
    if can? :update, @result
      if @result.update(result_params)
        redirect_to manage_event_path(@result.result_set.event, section: "results"), notice: "Saved result."
      else
        render :edit
      end
    else
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  def destroy
    @result = Result.find(params[:id])
    @event = @result.result_set.event
    if can? :destroy, @result
      if @result.destroy
        redirect_to manage_event_path(@event, section: "results"), notice: "Deleted result."
      else
        redirect_to manage_event_path(@event, section: "results"), notice: "Unable to delete result."
      end
    else
      redirect_to root_path, notice: "You need to be an admin to do that."
    end
  end
  
  private
  def result_params
    params.require(:result).permit(:user_id, :result_set_id, :position, :result)
  end
end
