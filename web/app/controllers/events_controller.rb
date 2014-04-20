class EventsController < ApplicationController
  def create

    event = Timeline::CreateEvent.run(:team_id => params[:team_id].to_i, :user_id => params[:user_id].to_i, :name => params[:name])
    @message = "Event created"
    flash[:notice] = "Event created."
    redirect_to team_show_path(params[:team_id])
  end
end
