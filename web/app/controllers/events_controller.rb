class EventsController < ApplicationController
  def create
    @event = Timeline::CreateEvent.run({
      user_id: params[:user_id].to_i,
      team_id: params[:id].to_i,
      name: params[:name]})
    if @event.success?
      flash[:notice] = "Event created"
      redirect_to team_show_path params[:id]
    else
      @error = @event.error
      render 'new'
    end
  end
end
